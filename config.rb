page '/index.html', layout: "main"

all_matches = Dir.foreach('./data/matches').map do |file|
  next if file == '.' || file == '..' || file.nil?
  YAML::load_file(File.join(__dir__, 'data/matches/' + file))
end.compact

all_matches.each do |match|
  match_id = match['match']
  proxy "/match/#{match_id}.html", "/matches.html",
    layout: "main",
    ignore: true,
    locals: {
      match_id: match_id,
    }
end

# all_teams = Dir.foreach('./data/matches').map do |file|
#   next if file == '.' || file == '..' || file.nil?
#   YAML::load_file(File.join(__dir__, 'data/matches/' + file))
# end.compact

all_matches.each do |team|
  match_team = team['team']
  proxy "/team/#{match_team}.html", "/teams.html",
    layout: "main",
    ignore: true,
    locals: {
      match_team: match_team,
    }
end

helpers do
  def team_path(team)
    "/team/#{team.team}.html"
  end
  def match_path(match)
    "/match/#{match.id}.html"
  end
end
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
  activate :relative_assets
end
