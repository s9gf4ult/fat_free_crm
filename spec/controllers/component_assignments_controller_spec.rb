require 'spec_helper'

describe ComponentAssignmentsController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'delete'" do
    it "returns http success" do
      get 'delete'
      response.should be_success
    end
  end

  describe "GET 'move_up'" do
    it "returns http success" do
      get 'move_up'
      response.should be_success
    end
  end

  describe "GET 'move_down'" do
    it "returns http success" do
      get 'move_down'
      response.should be_success
    end
  end

end
