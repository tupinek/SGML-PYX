use strict;
use warnings;

use File::Object;
use SGML::PYX;
use Test::More 'tests' => 7;
use Test::NoWarnings;
use Test::Output;

# Directories.
my $data_dir = File::Object->new->up->dir('data');

# Test.
my $obj = SGML::PYX->new;
my $right_ret = <<'END';
(element
)element
END
stdout_is(
	sub {
		$obj->parsefile($data_dir->file('element1.sgml')->s);
		return;
	},
	$right_ret,
	'Test single element.',
);

# Test.
$obj = SGML::PYX->new;
$right_ret = <<'END';
(element
Apar val
)element
END
stdout_is(
	sub {
		$obj->parsefile($data_dir->file('element2.sgml')->s);
		return;
	},
	$right_ret,
	'Test single element with attribute.',
);

# Test.
$obj = SGML::PYX->new;
$right_ret = <<'END';
(element
Apar val\nval
)element
END
stdout_is(
	sub {
		$obj->parsefile($data_dir->file('element3.sgml')->s);
		return;
	},
	$right_ret,
	'Test single element with advanced attribute.',
);

# Test.
$obj = SGML::PYX->new;
$right_ret = <<'END';
(element
Apar1 val1
Apar2 val2
)element
END
stdout_is(
	sub {
		$obj->parsefile($data_dir->file('element4.sgml')->s);
		return;
	},
	$right_ret,
	'Test single element with multiple attributes.',
);

# Test.
$obj = SGML::PYX->new;
$right_ret = <<'END';
(xml
-text
)xml
END
stdout_is(
	sub {
		$obj->parsefile($data_dir->file('element5.sgml')->s);
		return;
	},
	$right_ret,
	'Test element with one character data.',
);

# Test.
$obj = SGML::PYX->new;
$right_ret = <<'END';
(element
Aattr val val
)element
END
stdout_is(
	sub {
		$obj->parsefile($data_dir->file('element6.sgml')->s);
		return;
	},
	$right_ret,
	'Test simple element with attribute which has value with space.',
);
