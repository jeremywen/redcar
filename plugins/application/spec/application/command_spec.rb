require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe Redcar::Command do
  describe "a command" do
    before do
      $spec_command_env = nil
    end
    
    class MyCommand < Redcar::Command
      
      def execute
        $spec_command_env = {:win => win}
      end
    end

    it "is recordable by default" do
      MyCommand.record?.should be_true
    end
    
    it "has an environment" do
      command_instance = MyCommand.new
      command_instance.environment(:win => 123)
      command_instance.execute
      $spec_command_env.should == {:win => 123}
    end
  end
  
  describe "a non-recordable command" do
    class MyNonRecordableCommand < Redcar::Command
      norecord
    end
    
    it "is not recordable" do
      MyNonRecordableCommand.record?.should be_false
    end
  end
  
  describe "commands inherit sensitivities" do
    class SensitiveCommand < Redcar::Command
      sensitize :foo
    end
    
    class SubSensitiveCommand < SensitiveCommand
      sensitize :bar
    end
    
    it "has it's own and it's parent's sensitivities" do
      SubSensitiveCommand.sensitivity_names.should == [:foo, :bar]
    end
  end
end



