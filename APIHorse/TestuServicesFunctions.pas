unit TestuServicesFunctions;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Option,
  uServicesFunctions, System.Classes;

type
  // Test methods for class TServicesFunction

  TestTServicesFunction = class(TTestCase)
  strict private
    FServicesFunction: TServicesFunction;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBuild;
  end;

implementation

procedure TestTServicesFunction.SetUp;
begin
  FServicesFunction := TServicesFunction.Create;
end;

procedure TestTServicesFunction.TearDown;
begin
  FServicesFunction.Free;
  FServicesFunction := nil;
end;

procedure TestTServicesFunction.TestBuild;
begin
  FServicesFunction.Build;
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTServicesFunction.Suite);
end.

