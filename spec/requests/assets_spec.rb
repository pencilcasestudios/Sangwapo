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
    end
  end

  # jQuery assets
  describe "jQuery assets" do
    it "are available" do
      get "/assets/jquery.js"
      response.status.should be(200)

      get "/assets/jquery-ui.js"
      response.status.should be(200)
    end
  end

  # Twitter Bootstrap assets
  describe "Bootstrap assets" do
    it "are available" do
      get "/assets/bootstrap.css"
      response.status.should be(200)

      get "/assets/bootstrap.js"
      response.status.should be(200)

      get "/assets/glyphicons-halflings.png"
      response.status.should be(200)

      get "/assets/glyphicons-halflings-white.png"
      response.status.should be(200)
    end
  end

  # pcs_tablesorter assets
  describe "pcs_tablesorter assets" do
    it "are available" do
      get "/assets/tablesorter.js"
      response.status.should be(200)
    end
  end

  # Plugin assets
  describe "Plugin assets:" do
    it "charcount is available" do
      get "/assets/charcount.js"
      response.status.should be(200)
    end
  end
end
