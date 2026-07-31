macro define_getter(name)
  def {{name.id}}
    @{{name.id}}
  end
end

class Config
  @debug = false
  define_getter debug
end

{% if flag?(:release) %}
  puts "release mode"
{% end %}
