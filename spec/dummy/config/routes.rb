Rails.application.routes.draw do

  mount GraphEngine::Engine => "/graph_engine"
end
