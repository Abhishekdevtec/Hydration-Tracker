class BeverageEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_beverage_entry, only: [:show]

  def new
    @beverage_entry = current_user.beverage_entries.new
  end

  def create
    creator = BeverageEntryCreator.new(current_user, params)
    if creator.call
      redirect_to creator.beverage_entry, notice: "Beverage was successfully logged."
    else
      @beverage_entry = creator.beverage_entry
      render :new
    end
  end

  def show
  end
  
  def index
    @beverage_entries = current_user.beverage_entries.order(consumed_at: :desc)
    @entries_this_week = current_user.beverage_entries.where(consumed_at: 1.week.ago..Time.now)
    @total_quantity = @beverage_entries.sum(:quantity)
    @main_unit = "ml"
    @beverage_types = BeverageType.all
    @favorite_type = @beverage_entries.group(:beverage_type).count.max_by{|k,v| v}&.first&.name || "N/A"
  end
  
  def subtypes
    @subtypes = BeverageSubtype.where(beverage_type_id: params[:beverage_type_id])
    render json: @subtypes
  end
  
  private
  
  def set_beverage_entry
    @beverage_entry = current_user.beverage_entries.find(params[:id])
  end
  
  def beverage_entry_params
    params.require(:beverage_entry).permit(
      :beverage_type_id, :beverage_subtype_id, :custom_type,
      :quantity, :unit, :temperature, :notes, :consumed_at, :photo,
      beverage_addition_ids: []
    )
  end
end
