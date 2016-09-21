class CarsController < ApplicationController
  def index
    @cars = Car.all

    # проверяем на наличие position и его значения
    if params.has_key?(:position) && !params[:position].nil?
      # Обрабатываем параметр запроса:
      # - удаляем ненужные элементы запроса(скобки, случайные символы, пробелы)
      # - составляем массив
      user_position = params[:position].to_s.delete('a-zA-Z[]() ').split(',')
    else
      raise ActionController::RoutingError.new('Bad request')
    end

    # Рендерим JSON с единственным значением среднего времени подачи машины в минутах
    render json: Car.average_eta(@cars, user_position)
  end
end
