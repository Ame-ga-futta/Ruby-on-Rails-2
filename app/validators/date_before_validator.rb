class DateBeforeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank?
      record.errors[attribute] << "を入力してください"
    elsif value < Date.today
      record.errors[attribute] << "が過去の日付です"
    end
  end
end
