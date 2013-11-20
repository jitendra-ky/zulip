class zulip_internal::app_frontend {
  include zulip::app_frontend
  $app_packages = [# Needed for minify-js
                   "yui-compressor",
                   "nodejs",
                   # Needed for statsd reporting
                   "python-django-statsd-mozilla",
                   # Needed only for a disabled integration
                   "python-embedly",
                   ]
  package { $app_packages: ensure => "installed" }

  file { "/etc/nginx/zulip-include/app.d/accept-loadbalancer.conf":
    require => Package["nginx-full"],
    owner  => "root",
    group  => "root",
    mode => 644,
    source => "puppet:///modules/zulip_internal/nginx/zulip-include-app.d/accept-loadbalancer.conf",
    notify => Service["nginx"],
  }

  file { "/etc/cron.d/restart-workers":
    owner  => "root",
    group  => "root",
    mode => 644,
    source => "puppet:///modules/zulip_internal/cron.d/restart-workers",
  }

}
