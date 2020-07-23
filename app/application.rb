class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #If path equal items then print items
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    #if path equals cart then print contents
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |cart|
          resp.write "#{cart}\n"
        end
      end

      #if path equals add
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      if @@items.include? item_to_add
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        resp.write "We don't have that item!"
      end

      #Otherwise if path equals search
    elsif req.path.match(/search/)
      #Get value from Key Q entered in URL
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    else
      resp.write "Path Not Found"
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
