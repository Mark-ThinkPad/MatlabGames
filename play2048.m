classdef play2048 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure     matlab.ui.Figure
        GridLayout   matlab.ui.container.GridLayout
        EditField1   matlab.ui.control.EditField
        EditField5   matlab.ui.control.EditField
        EditField9   matlab.ui.control.EditField
        EditField13  matlab.ui.control.EditField
        EditField2   matlab.ui.control.EditField
        EditField6   matlab.ui.control.EditField
        EditField10  matlab.ui.control.EditField
        EditField14  matlab.ui.control.EditField
        EditField3   matlab.ui.control.EditField
        EditField7   matlab.ui.control.EditField
        EditField11  matlab.ui.control.EditField
        EditField15  matlab.ui.control.EditField
        EditField4   matlab.ui.control.EditField
        EditField8   matlab.ui.control.EditField
        EditField12  matlab.ui.control.EditField
        EditField16  matlab.ui.control.EditField
        Label1       matlab.ui.control.Label
        Label2       matlab.ui.control.Label
        EditField_2  matlab.ui.control.NumericEditField
        EditField_1  matlab.ui.control.NumericEditField
        Button       matlab.ui.control.Button
    end

    
    properties (Access = private)
        m % 4x4 matrix
        step % step number
        mc % 1x16 cell
        score % score
    end
    
    methods (Access = private)
        
        function refresh(app)
            app.EditField1.Value = num2str(app.mc{1});
            app.EditField2.Value = num2str(app.mc{2});
            app.EditField3.Value = num2str(app.mc{3});
            app.EditField4.Value = num2str(app.mc{4});
            app.EditField5.Value = num2str(app.mc{5});
            app.EditField6.Value = num2str(app.mc{6});
            app.EditField7.Value = num2str(app.mc{7});
            app.EditField8.Value = num2str(app.mc{8});
            app.EditField9.Value = num2str(app.mc{9});
            app.EditField10.Value = num2str(app.mc{10});
            app.EditField11.Value = num2str(app.mc{11});
            app.EditField12.Value = num2str(app.mc{12});
            app.EditField13.Value = num2str(app.mc{13});
            app.EditField14.Value = num2str(app.mc{14});
            app.EditField15.Value = num2str(app.mc{15});
            app.EditField16.Value = num2str(app.mc{16});
        end
        
        function add_2(app)
            try
                index = find(app.m == 0); %找为0的位置
                num = randperm(length(index), 1); % 随机挑一个位置
            catch ME
                app.step = app.step - 1;
                warndlg('游戏结束', '游戏结束');
                return
            end
            app.m(index(num)) = 2;            
            app.mc{index(num)} = 2;
        end
    
        function MToMC(app)
            index = find(app.m ~= 0);
            app.mc = cell(1, 16);
            for i = 1:length(index)
                app.mc{index(i)} = app.m(index(i));
            end
        end
        
        function move(app, direction)
            [x, y] = find(app.m ~= 0); % 索引有数字的位置点
            switch direction
                case 'up'
                    app.up(x,y,1); % 输入位置点和第1列数，合并
                    app.up(x,y,2); % 输入位置点和第2列数，合并
                    app.up(x,y,3); % 输入位置点和第3列数，合并
                    app.up(x,y,4); % 输入位置点和第4列数，合并
                case 'down'
                    app.down(x,y,1); % 输入位置点和第1列数，合并
                    app.down(x,y,2); % 输入位置点和第2列数，合并
                    app.down(x,y,3); % 输入位置点和第3列数，合并
                    app.down(x,y,4); % 输入位置点和第4列数，合并
                case 'left'
                    app.left(x,y,1); % 输入位置点和第1行数，合并
                    app.left(x,y,2); % 输入位置点和第2行数，合并
                    app.left(x,y,3); % 输入位置点和第3行数，合并
                    app.left(x,y,4); % 输入位置点和第4行数，合并
                case 'right'
                    app.right(x,y,1); % 输入位置点和第1行数，合并
                    app.right(x,y,2); % 输入位置点和第2行数，合并
                    app.right(x,y,3); % 输入位置点和第3行数，合并
                    app.right(x,y,4); % 输入位置点和第4行数，合并
            end
        end
    
        function up(app, x, y, n)
            index = find(y == n); % 找第一列的位置
            switch length(index)
                case 1
                    app.m(1, n) = app.m(x(index), y(index));
                    app.m(2:end, n) = 0;
                case 2
                    temp1 = app.m(x(index(1)), y(index(1)));
                    temp2 = app.m(x(index(2)), y(index(2)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        app.m(1, n) = temp;
                        app.m(2:end, n) = 0;
                    else
                        app.m(1, n) = temp1;
                        app.m(2, n) = temp2;
                        app.m(3:end, n) = 0;
                    end
                case 3
                    temp1 = app.m(x(index(1)), y(index(1)));
                    temp2 = app.m(x(index(2)), y(index(2)));
                    temp3 = app.m(x(index(3)), y(index(3)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        app.m(1, n) = temp;
                        app.m(2, n) = temp3;
                        app.m(3:end, n) = 0;
                    elseif temp2 == temp3
                        temp = temp2 + temp3;
                        app.score = app.score + temp;
                        app.m(1, n) = temp1;
                        app.m(2, n) = temp;
                        app.m(3:end, n) = 0;
                    else
                        app.m(1, n) = temp1;
                        app.m(2, n) = temp2;
                        app.m(3, n) = temp3;
                        app.m(4:end, n) = 0;
                    end
                case 4
                    temp1 = app.m(x(index(1)), y(index(1)));
                    temp2 = app.m(x(index(2)), y(index(2)));
                    temp3 = app.m(x(index(3)), y(index(3)));
                    temp4 = app.m(x(index(4)), y(index(4)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        if temp3 == temp4
                            tempp = temp3 + temp4;
                            app.score = app.score + tempp;
                            app.m(1, n) = temp;
                            app.m(2, n) = tempp;
                            app.m(3:end, n) = 0;
                        else
                            app.m(1, n) = temp;
                            app.m(2, n) = temp3;
                            app.m(3, n) = temp4;
                            app.m(4:end, n) = 0;
                        end
                    elseif temp2 == temp3
                        temp = temp2 + temp3;
                        app.score = app.score + temp;
                        app.m(1, n) = temp1;
                        app.m(2, n) = temp;
                        app.m(3, n) = temp4;
                        app.m(4:end, n) = 0;
                    elseif temp3 == temp4
                        temp = temp3 + temp4;
                        app.score = app.score + temp;
                        app.m(1, n) = temp1;
                        app.m(2, n) = temp2;
                        app.m(3, n) = temp;
                        app.m(4:end, n) = 0;
                    end
            end
        end
        
        function down(app, x, y, n)
            index = find(y == n); % 找第一列的位置
            switch length(index)
                case 1
                    app.m(4, n) = app.m(x(index), y(index));
                    app.m(3:-1:1, n) = 0;
                case 2
                    temp2 = app.m(x(index(1)), y(index(1)));
                    temp1 = app.m(x(index(2)), y(index(2)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        app.m(4, n) = temp;
                        app.m(3:-1:1, n) = 0;
                    else
                        app.m(4, n) = temp1;
                        app.m(3, n) = temp2;
                        app.m(2:-1:1, n) = 0;
                    end
                case 3
                    temp3 = app.m(x(index(1)), y(index(1)));
                    temp2 = app.m(x(index(2)), y(index(2)));
                    temp1 = app.m(x(index(3)), y(index(3)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        app.m(4, n) = temp;
                        app.m(3, n) = temp3;
                        app.m(2:-1:1, n) = 0;
                    elseif temp2 == temp3
                        temp = temp2 + temp3;
                        app.score = app.score + temp;
                        app.m(4, n) = temp1;
                        app.m(3, n) = temp;
                        app.m(2:-1:1, n) = 0;
                    else
                        app.m(4, n) = temp1;
                        app.m(3, n) = temp2;
                        app.m(2, n) = temp3;
                        app.m(1:-1:1, n) = 0;
                    end
                case 4
                    temp4 = app.m(x(index(1)), y(index(1)));
                    temp3 = app.m(x(index(2)), y(index(2)));
                    temp2 = app.m(x(index(3)), y(index(3)));
                    temp1 = app.m(x(index(4)), y(index(4)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        if temp3 == temp4
                            tempp = temp3 + temp4;
                            app.score = app.score + tempp;
                            app.m(4, n) = temp;
                            app.m(3, n) = tempp;
                            app.m(2:-1:1, n) = 0;
                        else
                            app.m(4, n) = temp;
                            app.m(3, n) = temp3;
                            app.m(2, n) = temp4;
                            app.m(1:-1:1, n) = 0;
                        end
                    elseif temp2 == temp3
                        temp = temp2 + temp3;
                        app.score = app.score + temp;
                        app.m(4, n) = temp1;
                        app.m(3, n) = temp;
                        app.m(2, n) = temp4;
                        app.m(1:-1:1, n) = 0;
                    elseif temp3 == temp4
                        temp = temp3 + temp4;
                        app.score = app.score + temp;
                        app.m(4, n) = temp1;
                        app.m(3, n) = temp2;
                        app.m(2, n) = temp;
                        app.m(1:-1:1, n) = 0;
                    end
            end
        end
        
        function left(app, x, y, n)
            index = find(x == n); % 找第一行的位置
            switch length(index)
                case 1
                    app.m(n, 1) = app.m(x(index), y(index));
                    app.m(n, 2:end) = 0;
                case 2
                    temp1 = app.m(x(index(1)), y(index(1)));
                    temp2 = app.m(x(index(2)), y(index(2)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        app.m(n, 1) = temp;
                        app.m(n, 2:end) = 0;
                    else
                        app.m(n, 1) = temp1;
                        app.m(n, 2) = temp2;
                        app.m(n, 3:end) = 0;
                    end
                case 3
                    temp1 = app.m(x(index(1)), y(index(1)));
                    temp2 = app.m(x(index(2)), y(index(2)));
                    temp3 = app.m(x(index(3)), y(index(3)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        app.m(n, 1) = temp;
                        app.m(n, 2) = temp3;
                        app.m(n, 3:end) = 0;
                    elseif temp2 == temp3
                        temp = temp2 + temp3;
                        app.score = app.score + temp;
                        app.m(n, 1) = temp1;
                        app.m(n, 2) = temp;
                        app.m(n, 3:end) = 0;
                    else
                        app.m(n, 1) = temp1;
                        app.m(n, 2) = temp2;
                        app.m(n, 3) = temp3;
                        app.m(n, 4:end) = 0;
                    end
                case 4
                    temp1 = app.m(x(index(1)), y(index(1)));
                    temp2 = app.m(x(index(2)), y(index(2)));
                    temp3 = app.m(x(index(3)), y(index(3)));
                    temp4 = app.m(x(index(4)), y(index(4)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        if temp3 == temp4
                            tempp = temp3 + temp4;
                            app.score = app.score + tempp;
                            app.m(n, 1) = temp;
                            app.m(n, 2) = tempp;
                            app.m(n, 3:end) = 0;
                        else
                            app.m(n, 1) = temp;
                            app.m(n, 2) = temp3;
                            app.m(n, 3) = temp4;
                            app.m(n, 4:end) = 0;
                        end
                    elseif temp2 == temp3
                        temp = temp2 + temp3;
                        app.score = app.score + temp;
                        app.m(n, 1) = temp1;
                        app.m(n, 2) = temp;
                        app.m(n, 3) = temp4;
                        app.m(n, 4:end) = 0;
                    elseif temp3 == temp4
                        temp = temp3 + temp4;
                        app.score = app.score + temp;
                        app.m(n, 1) = temp1;
                        app.m(n, 2) = temp2;
                        app.m(n, 3) = temp;
                        app.m(n, 4:end) = 0;
                    end
            end
        end
        
        function right(app, x, y, n)
            index = find(x == n); % 找第一行的位置
            switch length(index)
                case 1
                    app.m(n, 4) = app.m(x(index), y(index));
                    app.m(n, 3:-1:1) = 0;
                case 2
                    temp2 = app.m(x(index(1)), y(index(1)));
                    temp1 = app.m(x(index(2)), y(index(2)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        app.m(n, 4) = temp;
                        app.m(n, 3:-1:1) = 0;
                    else
                        app.m(n, 4) = temp1;
                        app.m(n, 3) = temp2;
                        app.m(n, 2:-1:1) = 0;
                    end
                case 3
                    temp3 = app.m(x(index(1)), y(index(1)));
                    temp2 = app.m(x(index(2)), y(index(2)));
                    temp1 = app.m(x(index(3)), y(index(3)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        app.m(n, 4) = temp;
                        app.m(n, 3) = temp3;
                        app.m(n, 2:-1:1) = 0;
                    elseif temp2 == temp3
                        temp = temp2 + temp3;
                        app.score = app.score + temp;
                        app.m(n, 4) = temp1;
                        app.m(n, 3) = temp;
                        app.m(n, 2:-1:1) = 0;
                    else
                        app.m(n, 4) = temp1;
                        app.m(n, 3) = temp2;
                        app.m(n, 2) = temp3;
                        app.m(n, 1:-1:1) = 0;
                    end
                case 4
                    temp4 = app.m(x(index(1)), y(index(1)));
                    temp3 = app.m(x(index(2)), y(index(2)));
                    temp2 = app.m(x(index(3)), y(index(3)));
                    temp1 = app.m(x(index(4)), y(index(4)));
                    if temp1 == temp2
                        temp = temp1 + temp2;
                        app.score = app.score + temp;
                        if temp3 == temp4
                            tempp = temp3 + temp4;
                            app.score = app.score + tempp;
                            app.m(n, 4) = temp;
                            app.m(n, 3) = tempp;
                            app.m(n, 2:-1:1) = 0;
                        else
                            app.m(n, 4) = temp;
                            app.m(n, 3) = temp3;
                            app.m(n, 2) = temp4;
                            app.m(n, 1:-1:1) = 0;
                        end
                    elseif temp2 == temp3
                        temp = temp2 + temp3;
                        app.score = app.score + temp;
                        app.m(n, 4) = temp1;
                        app.m(n, 3) = temp;
                        app.m(n, 2) = temp4;
                        app.m(n, 1:-1:1) = 0;
                    elseif temp3 == temp4
                        temp = temp3 + temp4;
                        app.score = app.score + temp;
                        app.m(n, 4) = temp1;
                        app.m(n, 3) = temp2;
                        app.m(n, 2) = temp;
                        app.m(n, 1:-1:1) = 0;
                    end
            end
        end
        
        function duringMove(app, direction)
            if nnz(app.m) ~= 17 %M中不为0的个数
                temp = 1;
                mp = app.m;
                app.move(direction);
                if sum(sum(abs(mp-app.m))) ~= 0 %如果前后有变化，才添加2
                    temp = 0;
                    app.add_2();
                    app.MToMC();
                    app.refresh();
                    app.step = app.step + 1;
                    app.EditField_2.Value = app.step;
                    app.EditField_1.Value = app.score;
                end
            end
            if nnz(app.m) == 16 && temp
                warndlg(strcat(direction, '方向不可移动'), '游戏提示');
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.step = 0;
            app.score = 0;
            app.m = zeros(4); % 创建一个4x4矩阵
            num = randperm(16, 2); % 1-16抽两个数
            app.m(num) = 2;
            app.MToMC();
            app.refresh();
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            app.EditField1.Value = '';
            app.EditField5.Value = '';
            app.EditField9.Value = '';
            app.EditField13.Value = '';
            app.EditField2.Value = '';
            app.EditField6.Value = '';
            app.EditField10.Value = '';
            app.EditField14.Value = '';
            app.EditField3.Value = '';
            app.EditField7.Value = '';
            app.EditField11.Value = '';
            app.EditField15.Value = '';
            app.EditField4.Value = '';
            app.EditField8.Value = '';
            app.EditField12.Value = '';
            app.EditField16.Value = '';
            app.EditField_1.Value = 0;
            app.EditField_2.Value = 0;
            app.startupFcn();
        end

        % Key press function: UIFigure
        function UIFigureKeyPress(app, event)
            key = event.Key;
            switch key
                case {'uparrow', 'w', 'W'}
                    app.duringMove('up');
                    % disp('方向键上');
                case {'downarrow', 's', 'S'}
                    app.duringMove('down');
                    % disp('方向键下');
                case {'leftarrow', 'a', 'A'}
                    app.duringMove('left');
                    % disp('方向键左');
                case {'rightarrow', 'd', 'D'}
                    app.duringMove('right');
                    % disp('方向键右');
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [1 1 1];
            app.UIFigure.Position = [100 100 382 492];
            app.UIFigure.Name = 'MATLAB 2048';
            app.UIFigure.Resize = 'off';
            app.UIFigure.KeyPressFcn = createCallbackFcn(app, @UIFigureKeyPress, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {'1x', '1x', '1x', '1x'};
            app.GridLayout.RowHeight = {'1x', '1x', '2x', '2x', '2x', '2x'};

            % Create EditField1
            app.EditField1 = uieditfield(app.GridLayout, 'text');
            app.EditField1.Editable = 'off';
            app.EditField1.HorizontalAlignment = 'center';
            app.EditField1.FontSize = 32;
            app.EditField1.FontWeight = 'bold';
            app.EditField1.Layout.Row = 3;
            app.EditField1.Layout.Column = 1;

            % Create EditField5
            app.EditField5 = uieditfield(app.GridLayout, 'text');
            app.EditField5.Editable = 'off';
            app.EditField5.HorizontalAlignment = 'center';
            app.EditField5.FontSize = 32;
            app.EditField5.FontWeight = 'bold';
            app.EditField5.Layout.Row = 3;
            app.EditField5.Layout.Column = 2;

            % Create EditField9
            app.EditField9 = uieditfield(app.GridLayout, 'text');
            app.EditField9.Editable = 'off';
            app.EditField9.HorizontalAlignment = 'center';
            app.EditField9.FontSize = 32;
            app.EditField9.FontWeight = 'bold';
            app.EditField9.Layout.Row = 3;
            app.EditField9.Layout.Column = 3;

            % Create EditField13
            app.EditField13 = uieditfield(app.GridLayout, 'text');
            app.EditField13.Editable = 'off';
            app.EditField13.HorizontalAlignment = 'center';
            app.EditField13.FontSize = 32;
            app.EditField13.FontWeight = 'bold';
            app.EditField13.Layout.Row = 3;
            app.EditField13.Layout.Column = 4;

            % Create EditField2
            app.EditField2 = uieditfield(app.GridLayout, 'text');
            app.EditField2.Editable = 'off';
            app.EditField2.HorizontalAlignment = 'center';
            app.EditField2.FontSize = 32;
            app.EditField2.FontWeight = 'bold';
            app.EditField2.Layout.Row = 4;
            app.EditField2.Layout.Column = 1;

            % Create EditField6
            app.EditField6 = uieditfield(app.GridLayout, 'text');
            app.EditField6.Editable = 'off';
            app.EditField6.HorizontalAlignment = 'center';
            app.EditField6.FontSize = 32;
            app.EditField6.FontWeight = 'bold';
            app.EditField6.Layout.Row = 4;
            app.EditField6.Layout.Column = 2;

            % Create EditField10
            app.EditField10 = uieditfield(app.GridLayout, 'text');
            app.EditField10.Editable = 'off';
            app.EditField10.HorizontalAlignment = 'center';
            app.EditField10.FontSize = 32;
            app.EditField10.FontWeight = 'bold';
            app.EditField10.Layout.Row = 4;
            app.EditField10.Layout.Column = 3;

            % Create EditField14
            app.EditField14 = uieditfield(app.GridLayout, 'text');
            app.EditField14.Editable = 'off';
            app.EditField14.HorizontalAlignment = 'center';
            app.EditField14.FontSize = 32;
            app.EditField14.FontWeight = 'bold';
            app.EditField14.Layout.Row = 4;
            app.EditField14.Layout.Column = 4;

            % Create EditField3
            app.EditField3 = uieditfield(app.GridLayout, 'text');
            app.EditField3.Editable = 'off';
            app.EditField3.HorizontalAlignment = 'center';
            app.EditField3.FontSize = 32;
            app.EditField3.FontWeight = 'bold';
            app.EditField3.Layout.Row = 5;
            app.EditField3.Layout.Column = 1;

            % Create EditField7
            app.EditField7 = uieditfield(app.GridLayout, 'text');
            app.EditField7.Editable = 'off';
            app.EditField7.HorizontalAlignment = 'center';
            app.EditField7.FontSize = 32;
            app.EditField7.FontWeight = 'bold';
            app.EditField7.Layout.Row = 5;
            app.EditField7.Layout.Column = 2;

            % Create EditField11
            app.EditField11 = uieditfield(app.GridLayout, 'text');
            app.EditField11.Editable = 'off';
            app.EditField11.HorizontalAlignment = 'center';
            app.EditField11.FontSize = 32;
            app.EditField11.FontWeight = 'bold';
            app.EditField11.Layout.Row = 5;
            app.EditField11.Layout.Column = 3;

            % Create EditField15
            app.EditField15 = uieditfield(app.GridLayout, 'text');
            app.EditField15.Editable = 'off';
            app.EditField15.HorizontalAlignment = 'center';
            app.EditField15.FontSize = 32;
            app.EditField15.FontWeight = 'bold';
            app.EditField15.Layout.Row = 5;
            app.EditField15.Layout.Column = 4;

            % Create EditField4
            app.EditField4 = uieditfield(app.GridLayout, 'text');
            app.EditField4.Editable = 'off';
            app.EditField4.HorizontalAlignment = 'center';
            app.EditField4.FontSize = 32;
            app.EditField4.FontWeight = 'bold';
            app.EditField4.Layout.Row = 6;
            app.EditField4.Layout.Column = 1;

            % Create EditField8
            app.EditField8 = uieditfield(app.GridLayout, 'text');
            app.EditField8.Editable = 'off';
            app.EditField8.HorizontalAlignment = 'center';
            app.EditField8.FontSize = 32;
            app.EditField8.FontWeight = 'bold';
            app.EditField8.Layout.Row = 6;
            app.EditField8.Layout.Column = 2;

            % Create EditField12
            app.EditField12 = uieditfield(app.GridLayout, 'text');
            app.EditField12.Editable = 'off';
            app.EditField12.HorizontalAlignment = 'center';
            app.EditField12.FontSize = 32;
            app.EditField12.FontWeight = 'bold';
            app.EditField12.Layout.Row = 6;
            app.EditField12.Layout.Column = 3;

            % Create EditField16
            app.EditField16 = uieditfield(app.GridLayout, 'text');
            app.EditField16.Editable = 'off';
            app.EditField16.HorizontalAlignment = 'center';
            app.EditField16.FontSize = 32;
            app.EditField16.FontWeight = 'bold';
            app.EditField16.Layout.Row = 6;
            app.EditField16.Layout.Column = 4;

            % Create Label1
            app.Label1 = uilabel(app.GridLayout);
            app.Label1.HorizontalAlignment = 'center';
            app.Label1.FontSize = 14;
            app.Label1.Layout.Row = 1;
            app.Label1.Layout.Column = 1;
            app.Label1.Text = '分数:';

            % Create Label2
            app.Label2 = uilabel(app.GridLayout);
            app.Label2.HorizontalAlignment = 'center';
            app.Label2.FontSize = 14;
            app.Label2.Layout.Row = 1;
            app.Label2.Layout.Column = 3;
            app.Label2.Text = '移动次数:';

            % Create EditField_2
            app.EditField_2 = uieditfield(app.GridLayout, 'numeric');
            app.EditField_2.Editable = 'off';
            app.EditField_2.HorizontalAlignment = 'center';
            app.EditField_2.FontSize = 24;
            app.EditField_2.FontWeight = 'bold';
            app.EditField_2.Layout.Row = 1;
            app.EditField_2.Layout.Column = 4;

            % Create EditField_1
            app.EditField_1 = uieditfield(app.GridLayout, 'numeric');
            app.EditField_1.Editable = 'off';
            app.EditField_1.HorizontalAlignment = 'center';
            app.EditField_1.FontSize = 24;
            app.EditField_1.FontWeight = 'bold';
            app.EditField_1.Layout.Row = 1;
            app.EditField_1.Layout.Column = 2;

            % Create Button
            app.Button = uibutton(app.GridLayout, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.FontSize = 14;
            app.Button.Layout.Row = 2;
            app.Button.Layout.Column = 4;
            app.Button.Text = '重新开始';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = play2048

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end