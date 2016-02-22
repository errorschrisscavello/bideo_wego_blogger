class LiquidPartialTag < Liquid::Tag
  def initialize(tag_name, params, tokens)
    super

    splitted = params.split(',')

    partial_name = splitted[0]
    partial_name = partial_name.match(/('|")?([^'"]+)('|")?/)

    if partial_name && partial_name[2]
      @name = partial_name[2].strip
    end

    if splitted.length > 1
      @params = parse_params(splitted[1..-1].join(',')) # TODO parse this better
    else
      @params = {}
    end
  end


  def render(context)
    merge_environment_with_params(context) if @params['_env']
    partial = Partial.find_by_name(@name)
    partial.data_file.render(@params).html_safe
  end




  private
  def parse_params(params)
    YAML.load(params)
  end


  def merge_environment_with_params(context)
    context.environments.each do |env|
      @params['_env'].each do |params_key, params_value|
        env.each do |env_key, env_value|
          if params_value == env_key
            @params[params_key] = env_value
          end
        end
      end
    end
  end
end

