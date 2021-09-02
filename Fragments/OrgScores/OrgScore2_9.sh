#!/bin/zsh

projectfolder=$(dirname "${0:A}")

source ${projectfolder}/Header.sh

CISLevel="1"
audit="2.9 Disable Power Nap (Automated)"
orgScore="OrgScore2_9"
emptyVariables
# Verify organizational score
runAudit
# If organizational score is 1 or true, check status of client
if [[ "${auditResult}" == "1" ]]; then
	method="Script"
	remediate="Script > sudo /usr/bin/pmset -a powernap 0"
	
	powerNap=$(pmset -g custom | awk '/powernap/ { sum+=$2 } END {print sum}')
	if [[ "${powerNap}" == "0" ]]; then
		result="Passed"
		comment="Power Nap: Enabled"
	else 
		result="Failed"
		comment="Power Nap: Disabled"
	fi
fi
printReport