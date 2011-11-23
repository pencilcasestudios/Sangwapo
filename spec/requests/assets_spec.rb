require "spec_helper"

describe "Assets" do
  # In app/assets/stylesheets/
  describe "app/assets/stylesheets/" do
    it "has stylesheet assets" do
      get "/assets/sessions.css"
      response.status.should be(200)

      get "/assets/styles.css"
      response.status.should be(200)

      get "/assets/users.css"
      response.status.should be(200)
    end
  end

  # In app/assets/images/
  describe "app/assets/images/" do
    it "has image assets" do
      get "/assets/apple-touch-icon.png"
      response.status.should be(200)

      get "/assets/apple-touch-icon-72x72.png"
      response.status.should be(200)

      get "/assets/apple-touch-icon-114x114.png"
      response.status.should be(200)

      get "/assets/favicon.ico"
      response.status.should be(200)

      get "/assets/Sangwapo-650x650.tiff"
      response.status.should be(200)

      #get "/assets/backgrounds/background0.jpg"
      #response.status.should be(200)
      #
      #get "/assets/backgrounds/background1.jpg"
      #response.status.should be(200)
      #
      #get "/assets/backgrounds/background2.jpg"
      #response.status.should be(200)
    end
  end

  # Twitter Bootstrap assets
  describe "Bootstrap assets" do
    it "are available" do
      get "/assets/bootstrap.css"
      response.status.should be(200)

      get "/assets/bootstrap.js"
      response.status.should be(200)
    end
  end

  ## Vegas jQuery Background plugin assets
  #describe "Vegas assets" do
  #  it "are available" do
  #    get "/assets/vegas.css"
  #    response.status.should be(200)
  #
  #    get "/assets/vegas.js"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/01.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/02.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/03.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/04.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/05.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/06.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/07.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/08.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/09.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/10.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/11.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/12.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/13.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/14.png"
  #    response.status.should be(200)
  #
  #    get "/assets/overlays/15.png"
  #    response.status.should be(200)
  #  end
  #end
end
