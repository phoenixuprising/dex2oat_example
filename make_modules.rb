require 'fileutils'

for i in 1..512 do
  FileUtils.mkdir_p "dummies/module-#{i}/src/main/java/"
  java_path = "dummies/module-#{i}/src/main/java/Module#{i}.java"  
  java_file = <<-EOF.chomp
package com.example.module#{i};

public class Module#{i} {
  public final int MODULE_NUMBER = #{i};
}
EOF
  File.write(java_path, java_file)

  gradle_path = "dummies/module-#{i}/build.gradle"
  gradle_file = <<-EOF
apply plugin: 'java-library'
EOF
  
  File.write(gradle_path, gradle_file)
  open('settings.gradle', 'a') { |f|
    f << "include ':dummies:module-#{i}'\n"
  }

  File.write(path, gradle_file)
  open('app/deps.txt', 'a') { |f|
    f << "implementation project(':dummies:module-#{i}')\n"
  }
end
