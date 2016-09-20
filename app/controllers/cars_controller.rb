class CarsController < ApplicationController
  def index
    @cars = Car.all

    # Обрабатываем параметр запроса:
    # - удаляем ненужные ненужные элементы запроса
    # - составляем массив
    user_position = params[:position].delete('a-zA-Z[] ').split(',')

    # Заполняем массив рассчитанными ETA для каждой свободной машины
    cars_eta = []
    @cars.each do |car|
      cars_eta << car.eta(user_position) if car.available
    end

    # Сортируем получившийся массив
    cars_eta.sort!

    # и выбираем первые три (ближайшие) машины
    average_eta = 0
    3.times do |i|
      average_eta += cars_eta[i]
    end

    # Наконец, рендерим JSON с единственным значением среднего времени подачи машины в минутах
    render json: (average_eta / 3).round
  end
end
