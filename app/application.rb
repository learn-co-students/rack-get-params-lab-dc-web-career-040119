class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each {|item| resp.write "#{item}\n"}

    elsif req.path.match(/cart/) && @@cart.length == 0
      resp.write "Your cart is empty"

    elsif req.path.match(/cart/) && @@cart.length > 0
      @@cart.each {|item| resp.write "#{item}\n"}

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/add/)
      search_term = req.params["q"]
      if @@items.include?(search_term)
        resp.write "added #{search_term}"
        @@cart << search_term
        elsif @@items.include?(search_term) == false
        resp.write "We don't have that item"
        else
        resp.write "Path Not Found"
      end
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
