require "multi_json"
require "open-uri"

module Brower

  VERSION = "0.1.0"

  def self.install dir=nil, depth=0

    return if depth > 5

    dir ||= Dir.pwd

    bowerrc_file_path = File.join dir, ".bowerrc"
    bower_json_file_path = File.join dir,"bower.json"
    return unless File.exist? bower_json_file_path
    bowerrc = MultiJson.load File.read bowerrc_file_path if File.exists? bowerrc_file_path 
    settings = {
        "directory"=>"bower_components",
        "registry"=>{
          "search"=>["https://bower.herokuapp.com"]
        }
      }.merge(bowerrc||{})
    #TODO: preconfigure and adhere to more settings from http://bower.io/docs/config/
    bower_json = MultiJson.load File.read bower_json_file_path
    bowerdir = settings["directory"]
    Dir.mkdir bowerdir unless Dir.exists?(bowerdir) || (bower_json['dependencies']||[])==[]
    registries = settings["registry"]["search"]

    (bower_json['dependencies']||[]).each do |pkg, details|
      req = open "#{registries.first}/packages/#{pkg}"
      info = MultiJson.load req
      pkg_dir = File.join bowerdir, pkg
      Dir.chdir bowerdir do
        `git clone #{info["url"]} #{pkg}`
      end
      install pkg_dir, depth+1
    end


  end
end
