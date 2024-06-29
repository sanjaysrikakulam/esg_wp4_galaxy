#!/bin/bash
GALAXY=/tmp/galaxy/

if (( $# == 0 )); then
	echo "specify main or test"
	exit 1
fi

if [[ $1 == "main" ]]; then
	folder="galaxy"
	ext=""
elif [[ $1 == "test" ]]; then
	folder="galaxy-test"
	ext="-test"
else
	echo "Unknown"
	exit 1
fi

if [[ $2 == "emacs" ]]; then
  difftool='emacs-ediff.sh'
elif [[ $2 == "meld" ]]; then
  difftool='meld'
else
  difftool='vimdiff'
fi

compare() {
	diff "$1" "$2" > /dev/null
	if (( $? > 0 )); then
		$difftool "$1" "$2"
	fi
}


compare files/$folder/config/data_manager_conf.xml	$GALAXY/config/data_manager_conf.xml.sample
compare files/$folder/config/datatypes_conf.xml	$GALAXY/config/datatypes_conf.xml.sample
compare files/$folder/config/dependency_resolvers_conf.xml	$GALAXY/config/dependency_resolvers_conf.xml.sample
#compare files/$folder/config/disposable_email_blacklist.conf	$GALAXY/config/disposable_email_blacklist.conf.sample
compare files/$folder/config/error_report.yml	$GALAXY/config/error_report.yml.sample
#compare files/$folder/config/job_metrics_conf.xml	$GALAXY/config/job_metrics_conf.xml.sample
compare files/$folder/config/migrated_tools_conf.xml	$GALAXY/config/migrated_tools_conf.xml.sample
#compare files/$folder/config/object_store_conf.xml	$GALAXY/config/object_store_conf.xml.sample
compare templates/$folder/config/oidc_backends_config.xml	$GALAXY/config/oidc_backends_config.xml.sample
compare templates/$folder/config/oidc_config.xml	$GALAXY/config/oidc_config.xml.sample
compare templates/$folder/config/tool_conf.xml.j2	$GALAXY/config/tool_conf.xml.sample
compare files/$folder/config/tool_data_table_conf.xml	$GALAXY/config/tool_data_table_conf.xml.sample
compare files/$folder/config/tool_sheds_conf.xml	$GALAXY/config/tool_sheds_conf.xml.sample
compare files/$folder/config/ucsc_build_sites.txt	$GALAXY/config/ucsc_build_sites.txt.sample
compare files/$folder/config/user_preferences_extra_conf.yml	$GALAXY/config/user_preferences_extra_conf.yml.sample
#compare templates/$folder/config/build_sites.yml.j2	$GALAXY/config/build_sites.yml.sample.sample

compare group_vars/gxconfig${ext}.yml	$GALAXY/config/galaxy.yml.sample