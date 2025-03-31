class BeverageEntryCreator
  def initialize(user, params)
    @user = user
    @params = params
    @beverage_entry = user.beverage_entries.new(beverage_entry_params)
  end

  def call
    set_custom_beverage_type
    combine_datetime
    if @beverage_entry.save
      handle_additions
      handle_symptoms
      true
    else
      false
    end
  end

  def beverage_entry
    @beverage_entry
  end

  private

  def beverage_entry_params
    @params.require(:beverage_entry).permit(
      :beverage_type_id, :beverage_subtype_id, :custom_type, :quantity, :unit,
      :temperature, :notes, :photo, :consumed_at
    )
  end

  def set_custom_beverage_type
    if @params[:beverage_entry][:beverage_type_id] == "-1" && @params[:beverage_entry][:custom_type].present?
      custom_type = BeverageType.find_or_create_by(name: @params[:beverage_entry][:custom_type], category: "custom")
      @beverage_entry.beverage_type = custom_type
      subtype = BeverageSubtype.find_or_create_by(name: custom_type.name, beverage_type: custom_type)
      @beverage_entry.beverage_subtype = subtype
    end
  end

  def combine_datetime
    if @params[:beverage_entry][:consumed_at_date].present? && @params[:beverage_entry][:consumed_at_time].present?
      date = Date.parse(@params[:beverage_entry][:consumed_at_date])
      time = Time.parse(@params[:beverage_entry][:consumed_at_time])
      @beverage_entry.consumed_at = Time.zone.local(date.year, date.month, date.day, time.hour, time.min)
    end
  end

  def handle_additions
    return unless @params[:beverage_entry][:addition_ids]

    @params[:beverage_entry][:addition_ids].each do |addition_id|
      if addition_id == "other" && @params[:beverage_entry][:other_addition].present?
        custom_add = BeverageAddition.find_or_create_by(name: @params[:beverage_entry][:other_addition])
        @beverage_entry.beverage_additions << custom_add
      else
        @beverage_entry.beverage_additions << BeverageAddition.find(addition_id) rescue nil
      end
    end
  end

  def handle_symptoms
    return unless @params[:has_symptoms] == "yes" && @params[:beverage_entry][:symptom_ids]

    @params[:beverage_entry][:symptom_ids].each do |symptom_id|
      if symptom_id == "other" && @params[:beverage_entry][:custom_symptom].present?
        custom_symptom = Symptom.find_or_create_by(name: @params[:beverage_entry][:custom_symptom])
        @beverage_entry.symptoms << custom_symptom
      else
        @beverage_entry.symptoms << Symptom.find(symptom_id) rescue nil
      end
    end

    if @beverage_entry.beverage_entry_symptoms.any?
      @beverage_entry.beverage_entry_symptoms.update_all(
        severity: @params[:symptom_severity],
        timing: @params[:symptom_timing],
        notes: @params[:symptom_notes]
      )
    end
  end
end