class Car < ActiveRecord::Base

  # Если position и available не заданы, объект не будет сохранен в базу
  validates :position, :available, presence: true


  # Статический метод, расчитывающий среднее ETA
  def self.average_eta(cars, user_position)
    # Заполняем массив рассчитанными ETA для каждой свободной машины
    cars_eta = []
    cars.each do |car|
      cars_eta << car.eta(user_position) if car.available
    end

    # Сортируем получившийся массив
    cars_eta.sort!

    # и выбираем среднее ETA:
    # - одной машины, если их всего 1
    # - двух машин, если их всего 2
    # - трех ближайших машин, если их 3 и больше
    average_eta = 0
    case cars_eta.size
      when 1
        cars_eta[0].round
      when 2
        2.times do |i|
          average_eta += cars_eta[i]
        end
        (average_eta / 2).round
      else
        3.times do |i|
          average_eta += cars_eta[i]
        end
        (average_eta / 3).round
    end
  end

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
