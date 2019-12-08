classdef menu < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure  matlab.ui.Figure
        Label     matlab.ui.control.Label
        Button1   matlab.ui.control.Button
        Button2   matlab.ui.control.Button
        Button3   matlab.ui.control.Button
    end

    
    properties (Access = private)
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: Button1
        function Button1Pushed(app, event)
            play2048
        end

        % Button pushed function: Button2
        function Button2Pushed(app, event)
            snake
        end

        % Button pushed function: Button3
        function Button3Pushed(app, event)
            minesweeper
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.9412 0.9412 0.9412];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = '小游戏三合一';
            app.UIFigure.Resize = 'off';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontName = '华文彩云';
            app.Label.FontSize = 52;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [151 341 329 90];
            app.Label.Text = {'小游戏三合一'; ''};

            % Create Button1
            app.Button1 = uibutton(app.UIFigure, 'push');
            app.Button1.ButtonPushedFcn = createCallbackFcn(app, @Button1Pushed, true);
            app.Button1.FontName = 'Arial';
            app.Button1.FontSize = 24;
            app.Button1.Position = [221 241 180 50];
            app.Button1.Text = '2048';

            % Create Button2
            app.Button2 = uibutton(app.UIFigure, 'push');
            app.Button2.ButtonPushedFcn = createCallbackFcn(app, @Button2Pushed, true);
            app.Button2.FontName = 'Arial';
            app.Button2.FontSize = 24;
            app.Button2.Position = [221 161 180 50];
            app.Button2.Text = '贪吃蛇';

            % Create Button3
            app.Button3 = uibutton(app.UIFigure, 'push');
            app.Button3.ButtonPushedFcn = createCallbackFcn(app, @Button3Pushed, true);
            app.Button3.FontName = 'Arial';
            app.Button3.FontSize = 24;
            app.Button3.Position = [221 81 180 50];
            app.Button3.Text = '扫雷';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = menu

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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