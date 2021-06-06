
c=2;


%  image(nframe, 'Parent', currAxes);
%  currAxes.Visible = 'off';
vidObj = VideoReader('vn.mp4');
val=1;
count=1;
while hasFrame(vidObj)
    frame2 = readFrame(vidObj);
    frame2=rgb2gray(frame2);
    thersold = graythresh(frame2);
    
    
    frame2=~im2bw(frame2,0.3);
    
    
    for i=1:size(frame2,1)
        for j=1:size(frame2,2)
            if frame2(i,j)==1
                figure();
                
                imshow(frame2);
                title(sprintf('Current Time = %.3f sec',vidObj.CurrentTime));
                firstframe=frame2;
                pause(3/vidObj.FrameRate);
                if c==2
                    initialtime=vidObj.CurrentTime;
                    cordX1=i;
                    cordY1=j;
                    c=c+1;
                end
                
                val=1;
                break;
            end
        end
        if val==1
            break;
        end
    end
    
    if val==1
        while val~=0
            frame2=readFrame(vidObj);
            frame2=~im2bw(frame2,0.3);
            for i=1:size(frame2,1)
                for j=1:size(frame2,2)
                    if frame2(i,j)==0
                        f=0;
                        x2=i;
                        y2=j;
                    else
                        f=1;
                        break;
                    end
                    
                    
                end
            end
            if f==0
                
                figure();
                
                
                imshow(frame2);
                title(sprintf('Current Time = %.3f sec',vidObj.CurrentTime));
                lastframe=frame2;
                cordX2=x2;
                cordY2=y2;
                finaltime=vidObj.CurrentTime;
                
                pause(2/vidObj.FrameRate);
                val=0;
                
            end
        end
        
    end
    
    
    
    count=count+1;
    if val==1
        break;
    end
    
    
    
end

distance=sqrt((cordX1-cordX2)^2 +(cordY1-cordY2)^2);
time=finaltime-initialtime; % time when car appear - time when car is hoing dissapeared
speed_car=distance/time;
disp(speed_car);