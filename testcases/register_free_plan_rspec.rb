#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../tools/register_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../action/register_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"

describe "Register -> sign in" do 
	include RegisterDialog
    include SignInGithubDialog
	include BaseEnv
	include ConfigParam

	before(:all) do 
		init
		@driver = browser
		@register_page = RegisterPage.new @driver
		# @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    it "With invalid Adobe ID (Email Address)" do 
    	@driver.get path_format_locale("/plans/free-adobeid") 
    	enter_email()
    	enter_password()
    	sign_in_btn.click
    	xxx.should eql @data_str[$lang][:PGB_the_Adobe_ID_password_not_match]
    end

    it "With wrong password" do 
    	@driver.get path_format_locale("/plans/free-adobeid") 
    	enter_email()
    	enter_password()
    	sign_in_btn.click
    	xxx.should eql @data_str[$lang][:PGB_the_Adobe_ID_password_not_match]
    end

    it "sign in successfully" do 
    	@driver.get path_format_locale("/plans/free-adobeid") 
    	enter_email()
    	enter_password()
    	sign_in_btn.click
    	sleep 5
    	read_accept_terms_checkbox.click
    	@driver.current_url.should eql @data_url[:sign_in_successfully]
    end
end