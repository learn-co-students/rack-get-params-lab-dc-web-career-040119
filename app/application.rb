class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif 
      req.path.match(/cart/)
      if
        @@cart.empty?
          resp.write "Your cart is empty"
        
        else 
         @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
     elsif
      req.path.match(/add/) #adds a new route
      search = req.params["item"] #params serach for a key work "item" |parameter| 
      if 
        @@items.include?(search)#validation  true or false.
         @@cart << search #if the key enteris found inside @@items array. shovel <<  into @@cart
        resp.write "added #{search}" #puts
    else 
      resp.write "We don't have that item"
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
