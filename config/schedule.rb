set :output, 'log/crontab.log'
set :environment, :development

every 1.hours do
  runner 'Coupon.coupon_create'
end