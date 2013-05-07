require("test/lovemock")

Test = {}
Test.cases = {}
Test.results = {}
Test.global_results = {pass=0, fail=0}

function Test.create(name)
  local instance = {name=name}
  Test.cases[#Test.cases+1] = instance
  return instance
end

function Test.invoke_all()
  for i=1,#Test.cases do
    testcase = Test.cases[i]
    Test.results[testcase] = {}
    for testname,testfunction in pairs(testcase) do
      if string.match(testname, "^test_") then
        ok, err = pcall(testfunction)
        if ok then
          Test.results[testcase][testname] = {"pass"}
          Test.global_results.pass = Test.global_results.pass + 1
          print(". " .. testcase.name .. "." .. testname)
        else
          Test.results[testcase][testname] = {"fail", err}
          print("F " .. testcase.name .. "." .. testname)
          print(err)
          Test.global_results.fail = Test.global_results.fail + 1
        end
      end
    end
  end
end

function assert_kind_of(expected, actual)
  local t = type(actual)
  if t ~= expected then
    error("Type mismatch.", 2)
  end
end

function assert_instance_of(expected, actual)
  local mt = getmetatable(actual)
  if mt ~= expected then
    error("Type mismatch.", 2)
  end
end

function assert_not_nil(actual)
  if actual == nil then
    error("Nil value.")
  end
end

function assert_equal(expected, actual)
  if actual ~= expected then
    error("Expected " .. expected .. ", got " .. actual)
  end
end
