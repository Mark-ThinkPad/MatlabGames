function snake
  axis equal                    %设置坐标轴为对称      
  axis(0.5+[0, 20, 0, 20])          %加0.5是为了之后的墙壁碰撞检测的方便
  set(gca,'xtick',[],'ytick',[],'xcolor','w','ycolor','w')      %隐藏坐标轴
  set(gca, 'color', 'y')
  hold on                                                  
  snakeTop = [5, 5];                   %这是蛇头的初始位置
  snakeDirect = [1, 0];                %蛇的方向
  body = [5, 5 ; 4, 5 ; 3, 5];          %蛇身的初始位置数组  
  long = 3;                                 %蛇的长度            
  food = [10, 10];                        %食物的初始位置
  plotSnake = scatter(gca, body(:, 1), body(:, 2), 220, 'bs', 'filled');                  %通过函数scatter画出蛇身，scatter是画散点图的函数
  plotFood = scatter(gca, food(1), food(2), 150, 'g', 'filled');                           %通过函数scatter画出食物
  set(gcf, 'KeyPressFcn', @key)                                                                     %设置按键判断
  fps = 5;                                    
  game = timer('ExecutionMode', 'FixedRate', 'Period',1/fps, 'TimerFcn', @snakeGame);       %设置定时器的参数
  start(game)                               %开始游戏
 
   function snakeGame(~,~)
    snakeTop = snakeTop + snakeDirect;              %蛇的移动
    body = [snakeTop; body] ;                                 
    while length(body)> long
      body(end, : ) = [];         
    end
    
    if intersect(body(2 : end, : ), snakeTop, 'rows')               %判断蛇头是否撞到自己的身体
        ButtonName1 = questdlg('游戏结束，请点击按钮继续......','Gave Over','重新开始','关闭游戏', 'Yes');
        if ButtonName1 == '重新开始'
            clf;
            snake();
        else
            close;
        end
    end      
    
    if isequal(snakeTop, food)             %判断是否吃到食物
      long = long + 1;                   
      food = randi(20, [1, 2]); 
      while any(ismember(body, food, 'rows'))
          food = randi(20, [1, 2]);
      end
    end        
    
    if (snakeTop(1, 1)>20)||(snakeTop(1, 1)<1)||(snakeTop(1, 2)>20)||(snakeTop(1, 2)<1)         %判断是否撞到墙壁
        ButtonName2 = questdlg('游戏结束，请点击按钮继续......','Gave Over','重新开始','关闭游戏', '关闭游戏');
        if ButtonName2 == '重新开始'
            clf;
            snake();
        else
            close;
        end
    end
    
    set(plotFood, 'XData', food(1),  'YData', food(2));             %不断的刷新画面
    set(plotSnake, 'XData', body( : , 1), 'YData', body( : , 2));
  end
 
  function key(~,event)       
    switch event.Key            
      case 'uparrow'
        direct = [0, 1];
      case 'downarrow'
        direct = [0, -1];
      case 'leftarrow'
        direct = [-1, 0];
      case 'rightarrow'
        direct = [1, 0];
      case 'space'
        stop(game); 
        direct = snakeDirect;
        ButtonName3 = questdlg('游戏暂停......', 'Stop ', '重新开始', '关闭游戏', '继续游戏', '关闭游戏');
        if ButtonName3 == '重新开始'
            clf;
            snake();
        elseif ButtonName3 == '关闭游戏'
            close;
        else
           start(game);
        end   
      otherwise
        direct = nan;
    end
    if any(snakeDirect + direct)   
      snakeDirect = direct;
    end
  end
end