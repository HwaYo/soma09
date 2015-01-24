class Admin::ApplicationController < ApplicationController
  skip_before_action :authenticate_user!

  http_basic_authenticate_with name: "hwayo", password: "hwayo1234"
end
