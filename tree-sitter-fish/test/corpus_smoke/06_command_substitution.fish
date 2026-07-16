# Command substitution in both styles
set today (date +%Y-%m-%d)
set kernel $(uname -s)
echo "today is $today on $kernel"
echo (hostname) has (nproc) cores
