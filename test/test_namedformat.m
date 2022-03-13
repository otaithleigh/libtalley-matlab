function tests = test_namedformat()
    tests = functiontests(localfunctions());
end

function test_templating(testCase)
    template = fileread('static.tcl.in');
    expected = string(fileread('static.tcl'));

    options = {
        'timestamp',       '13-Mar-2022 04:04:04'
        'units.force',     'kip'
        'units.length',    'inch'
        'units.time',      's'
        'dependencies',    'package require OpenSeesComposite'
        'imports',         ''
        'model_script',    '<Model script>'
        'timeseries.tag',  1
        'pattern.tag',     1
        'pattern.loads',   '    load 0 0.0 1.0 0.0'
        'recorders',       '<Recorders>'
        'constraints',     'Plain'
        'numberer',        'RCM'
        'system',          'UmfPack'
        'test',            'NormDispIncr ...'
        'algorithm',       'KrylovNewton'
        'load_control',    'integrator LoadControl ...'
    };

    options = containers.Map(options(:,1), options(:,2));
    actual = namedformat(template, options);
    verifyEqual(testCase, actual, expected);
end
