# encoding: UTF-8

control "V-55979" do
  title "The NGINX web server must generate log records that can be mapped to
Coordinated Universal Time (UTC) or Greenwich Mean Time (GMT)."
  desc  "If time stamps are not consistently applied and there is no common
time reference, it is difficult to perform forensic analysis across multiple
devices and log records.

    Time stamps generated by the web server include date and time. Time is
commonly expressed in Coordinated Universal Time (UTC), a modern continuation
of Greenwich Mean Time (GMT), or local time with an offset from UTC.
  "
  
  desc  "check", "
  Review the NGINX web server documentation and configuration to determine the time
  stamp format for log data.

  Check for the following:
      # grep for all 'env' directives in the main context of the nginx.conf.

  If the 'env' directive cannot be found in NGINX configuration files, this check is
  Not Applicable. 
  
  If neither 'env TZ=UTC' or 'env TZ=GMT' exists, this is a finding.
  "
  desc  "fix", "Configure the 'TZ' environment variable in the nginx.conf to store 
  log data time stamps in a format that is mappted to UTC or GMT time.

  Example configuration:
  'env TZ=UTC;' 
  or
  'env TZ=GMT;'"
  
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "SRG-APP-000374-WSR-000172"
  tag "gid": "V-55979"
  tag "rid": "SV-70233r2_rule"
  tag "stig_id": "SRG-APP-000374-WSR-000172"
  tag "fix_id": "F-60857r1_fix"
  tag "cci": ["CCI-001890"]
  tag "nist": ["AU-8 b", "Rev_4"]

  if nginx_conf.params['env'].nil?
    impact 0.0
    describe 'This check is NA because the env directive has not been configured.' do
      skip 'This check is NA because the env directive has not been configured.'
    end
  else
    describe.one do 
      describe nginx_conf.params['env'].join do
        it { should cmp "TZ=UTC" }
      end
      describe nginx_conf.params['env'].join do
        it { should cmp "TZ=GMT" }
      end
    end
  end
end

