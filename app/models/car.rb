class Car < ActiveRecord::Base

  # Если position и available не заданы, объект не будет сохранен в базу
  validates :position, :available, presence: true

  # Расчитываем примерное время подачи данной машины
  def eta(user_position)
    car_position = self.position.split(' ')

    r = 6371

    # Переводим градусы в радианы
    lat1 = car_position[0].to_f / 180 * Math::PI
    long1 = car_position[1].to_f / 180 * Math::PI
    lat2 = user_position[0].to_f / 180 * Math::PI
    long2 = user_position[1].to_f / 180 * Math::PI

    sin1 = Math.sin((lat1 - lat2) / 2)
    sin2 = Math.sin((long1 - long2) / 2)
    eta = 1.5 * 2 * r * Math.asin(Math.sqrt((sin1**2) + (Math.cos(lat1) * Math.cos(lat2) * (sin2**2))))
  end
end
