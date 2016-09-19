class Car < ActiveRecord::Base
  def eta
    user_position = [59.68585959, 30.44572771]
    car_position = self.position.split(' ')

    lat1 = car_position[0].to_f/180 * Math::PI
    long1 = car_position[1].to_f/180 * Math::PI
    lat2 = user_position[0]/180 * Math::PI
    long2 = user_position[1]/180 * Math::PI
    r = 6371
    sin1 = Math.sin((lat1 - lat2)/2)
    sin2 = Math.sin((long1 - long2)/2)
    eta =1.5*2*r*Math.asin(Math.sqrt((sin1**2) + (Math.cos(lat1)*Math.cos(lat2)*(sin2**2))))
    eta.round(3)
  end
end
