m=20;
n=220;
for x=0:1:255
    if x<50
        y=(m/50.*x);
    else if x<200
            y=((n-m)/150*x+(4*m-n)/3);
        else y=((255-n)/55*x+(51*n-10200)/11);
        end
    end

plot(x,y,'b:.');hold on;
title("Mapping Function");
xlabel("Input Graylevel");
ylabel("Output Graylevel");
end
text(50,20,'\fontsize{15}(50,20)');
text(200,220,'\fontsize{15}(200,220)');
text(255,255,'\fontsize{15}(255,255)');