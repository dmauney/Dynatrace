# 1. Take a series of quick dumps to have something at least!
/opt/app/jstack_series.sh $1 
# 2. Spread the dumps out a bit to get more useful diagnostics (but beware the PID dying)
/opt/app/jstack_series.sh $1 10 10

