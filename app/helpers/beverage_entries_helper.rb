module BeverageEntriesHelper
  def temperature_emoji(temp)
    temp = temp.to_i

    case temp
    when 0..4 then "❄️"
    when 5..10 then "🧊"
    when 11..15 then "🥶"
    when 16..25 then "🌡️"
    when 26..35 then "🔥"
    when 36..50 then "♨️"
    else "🌡️"
    end
  end

  def temperature_label(temp)
    temp = temp.to_i

    case temp
    when 0..4 then "Ice Cold"
    when 5..10 then "Chilled"
    when 11..15 then "Cool"
    when 16..25 then "Room Temp"
    when 26..35 then "Warm"
    when 36..50 then "Hot"
    when 51..100 then "Boiling"
    else "Normal"
    end
  end

  def celsius_to_fahrenheit(c)
    (c.to_f * 9/5 + 32).round
  end
end
