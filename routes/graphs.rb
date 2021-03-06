require 'gruff'

class GasTracker
  
  get '/graph' do
    "Graphs!"
  end

  get '/graph/gas_cost_over_time.png' do
    width = (params[:width] || 280).to_i

    g = Gruff::Line.new(width)
    g.title = "Gas cost over time"

    cost_data = Purchase.all.map{|p| p.cost_per_gallon._round_to(2)}

    g.minimum_value = cost_data.min.floor
    g.maximum_value = cost_data.max.ceil
    g.data("Cost", cost_data, '#96f')
    g.hide_dots = true
    g.hide_legend = true
    g.theme = g.theme_greyscale
    
    path = './tmp/gas_cost_over_time.png'
    g.write(path)
    send_file path, :type => "image/png", :disposition => "inline"
  end

  get '/graph/mpg_over_time.png' do
    width = (params[:width] || 280).to_i

    g = Gruff::Line.new(width)
    g.title = "MPG over time"

    mpg_data = Purchase.all.map{|p| p.miles_per_gallon._round_to(2)}

    g.minimum_value = mpg_data.min.floor
    g.maximum_value = mpg_data.max.ceil
    g.data("MPG", mpg_data, '#96f')
    g.hide_dots = true
    g.hide_legend = true
    g.theme = g.theme_greyscale

    path = './tmp/mpg_over_time.png'
    g.write(path)
    send_file path, :type => "image/png", :disposition => "inline"
  end

end
