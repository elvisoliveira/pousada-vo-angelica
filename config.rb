config[:language] = "pt-br"

config[:email] = "markar@markar.com.br"
config[:author] = "Markar"
config[:reference] = "http://www.markar.com.br/"

config[:name] = "Pousada V&oacute; Ang&eacute;lica"
config[:keywords] = "pousada, pousadas, hotel, hotéis, retiro, marechal, floriano, espirito, espírito, santo, brasil, brazil"
config[:description] = "Pousada localizada em Marechal Floriano, confortáveis apartamentos com TV, suíte e frigobar, café da manhã e colônial, área de piscina com churrasqueira, trilhas ecológicas e muito mais!"
config[:address] = "Rua Antenor dos Santos Braga, 254, Centro, Marechal Floriano - ES"
config[:contact] = "Tel: (27) 3288-1362 / 9984 - 0079"

activate :blog do |blog|
  blog.sources = "blog/{title}.html"
  blog.permalink = "{title}.html"
  blog.layout = "blog"
end

configure :build do
  activate :minify_html do |html|
    html.remove_multi_spaces = true
    html.remove_intertag_spaces = true
    html.remove_comments = true
  end
  set :http_prefix, ENV['BASE_URL'] || "/"
end

redirect "fotos.html", to: "fotos_1.html"

ignore "gallery.html"

ready do
  photos = @app.data.fotos
  start_index = 0
  page_num = 1
  per_page = 8

  while start_index <= photos.size
    proxy "fotos_#{page_num}.html", "gallery.html", :locals => {
        :photos => photos.slice(start_index, per_page),
        :current => page_num,
        :total => photos.size.fdiv(per_page).ceil
    }
    start_index += per_page
    page_num += 1
  end
end