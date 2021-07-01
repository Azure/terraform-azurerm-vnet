# Official gems.
require 'colorize'
require 'rspec/core/rake_task'

# Git repo gems.
require 'bundler/setup'
require 'terramodtest'

namespace :presteps do
  task :fmt do
    puts "Format Terraform code.\n"
    success = system('terraform fmt --recursive .')
    if not success 
      raise "ERROR: Terraform format failed.\n".red
    end
  end

  task :ensure do
    puts "Downloading missing go modules and remove unused ones.\n"
    success = system('go get github.com/katbyte/terrafmt && go mod tidy')
    if not success 
      raise "ERROR: Failed to tidy go depedencies!\n".red
    end
  end

  task :clean do
    puts "Clean out the temporary terraform files in test folder.\n"
    FileUtils.rm_r(['./test/fixture/.terraform', './test/fixture/.terraform.lock.hcl'], force: true)
  end
end

namespace :static do
  task :style do
    style_tf
  end
  task :lint do
    lint_tf
  end
  task :format do
    format_tf
  end
  task :readme_style do
    readme_style_tf
  end
  task :fixture_style do
    fixture_style_tf
  end
end

namespace :test do
  task :unit do
    success = system ("go test -v ./test/unit/ -timeout 20m")
    if not success 
      raise "ERROR: Go test failed!\n".red
    end
  end

  task :integration do
    success = system ("go test -v ./test/integration -timeout 20m")
    if not success 
      raise "ERROR: Go test failed!\n".red
    end
  end
end

task :prereqs => [  'presteps:fmt', 'presteps:ensure', 'presteps:clean' ]

task :validate => [ 'static:style', 'static:lint', 'static:readme_style','static:fixture_style' ]

task :format => [ 'static:format' ]

task :build => [ 'prereqs', 'validate' ]

task :unit => [  'build', 'test:unit' ]

task :e2e => [  'build', 'test:integration' ]

task :default => [ 'build' ]

task :full => [ 'build', 'unit', 'e2e' ]
