# parser_class
class Parser
  def initialize(log_file_path)
    validate_file(log_file_path)
    @parser = {}
    generate_parser_object(log_file_path)
  end

  def list_views(sort = 'DSC')
    page_visits = @parser.keys.map { |k| { k => @parser[k].values.sum } }
    if sort == 'ASC'
      page_visits.sort_by { |page, _visits| page.values }
    else
      page_visits.sort_by { |page, _visits| page.values }.reverse
    end
  end

  def uniq_views(sort = 'DSC')
    page_visits = @parser.map { |page, _ipvisits| { page => @parser[page].count } }
    if sort == 'ASC'
      page_visits.sort_by { |page, _visits| page.values }
    else
      page_visits.sort_by { |page, _visits| page.values }.reverse
    end
  end

  # most views for a particuar page by a particular IP
  # def most_views_by_ip
  #   @parser.map { |page, ip_visits| { page => ip_visits.max_by { |_ip, visits| visits } } }
  # end

  private

  def validate_file(file_path)
    raise "Log file not found at #{file_path}" unless File.exist?(file_path)
  end

  def generate_parser_object(file)
    f = File.open(file, 'r')
    begin
      f.each do |line|
        page, ip = line.split
        add_page_ip(page, ip)
      end
      f.close
    rescue
      raise 'Not able to process logs'
    end
  end

  def add_page_ip(page, ip)
    if @parser.key?(page)
      @parser[page].key?(ip) ? @parser[page][ip] += 1 : @parser[page].merge!({ ip => 1 })
    else
      @parser[page] = { ip => 1 }
    end
  end
end

# puts Parser.new("./logs/webserver.log").uniq_views
