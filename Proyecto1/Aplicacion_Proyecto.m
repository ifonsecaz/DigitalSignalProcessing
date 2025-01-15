classdef Aplicacion_Proyecto < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        GridLayout                     matlab.ui.container.GridLayout
        LeftPanel                      matlab.ui.container.Panel
        Button2                        matlab.ui.control.Button
        Button                         matlab.ui.control.Button
        PlayButton                     matlab.ui.control.Button
        NotasTextArea                  matlab.ui.control.TextArea
        NotasTextAreaLabel             matlab.ui.control.Label
        AnchodeBandaEditField          matlab.ui.control.EditField
        AnchodeBandaEditFieldLabel     matlab.ui.control.Label
        HzLabel                        matlab.ui.control.Label
        sLabel                         matlab.ui.control.Label
        FrecuenciadeMuestreoEditField  matlab.ui.control.EditField
        FrecuenciadeMuestreoLabel      matlab.ui.control.Label
        DuracinEditField               matlab.ui.control.EditField
        DuracinEditFieldLabel          matlab.ui.control.Label
        AudioFileDropDown              matlab.ui.control.DropDown
        AudioFileDropDownLabel         matlab.ui.control.Label
        RightPanel                     matlab.ui.container.Panel
        SFinal                         matlab.ui.control.UIAxes
        Espect                         matlab.ui.control.UIAxes
        Picos                          matlab.ui.control.UIAxes
        DomTiempo                      matlab.ui.control.UIAxes
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: AudioFileDropDown
        function AudioFileDropDownValueChanged(app, event)
            %Se elige el valor actual en la lista "drop down". Se utiliza
            %este valor para correr la función principal (PicosNotasFun)
            %y el síntesis de notas (SintesisDeNotas).
            value = app.AudioFileDropDown.Value;
            [dur,fms,y,yAux,locs,picos,frecs,tiempos,maxT,melodia,ancho,notas] = PicosNotasFun(value);
            plot(app.DomTiempo,y)
            app.DuracinEditField.Value = sprintf('%f', dur);
            app.FrecuenciadeMuestreoEditField.Value = sprintf('%1.1f', fms);
            app.AnchodeBandaEditField.Value = sprintf(ancho);
            plot(app.Picos,1:numel(yAux),yAux,'-',locs(picos),yAux(locs(picos)),'o')
            app.NotasTextArea.Value = melodia;
            
            SintesisDeNotas(notas,tiempos,fms,maxT);
            [y,fs] = audioread('salida.wav');
            plot(app.SFinal,y)
            
            ax = app.Espect;
            Y = decimate(y,10);
            [S,F,T] = spectrogram(Y,1024,0,1024,fms,'yaxis');
            imagesc(ax, T, F, log(1+abs(S)));
            set(ax,'YDir', 'normal');
            colorbar(ax);
        end

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            %Simple botón para tocar la pieza elegida
            value = app.AudioFileDropDown.Value;
            [y,fs] = audioread(value);
            sound(y,fs)
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 2x1 grid
                app.GridLayout.RowHeight = {504, 504};
                app.GridLayout.ColumnWidth = {'1x'};
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 1;
            else
                % Change to a 1x2 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {220, '1x'};
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 2;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 1097 504];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {220, '1x'};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create AudioFileDropDownLabel
            app.AudioFileDropDownLabel = uilabel(app.LeftPanel);
            app.AudioFileDropDownLabel.HorizontalAlignment = 'center';
            app.AudioFileDropDownLabel.Position = [18 459 65 22];
            app.AudioFileDropDownLabel.Text = 'Audio File';

            % Create AudioFileDropDown
            app.AudioFileDropDown = uidropdown(app.LeftPanel);
            app.AudioFileDropDown.Items = {'Seleccionar', 'theme1.wav', 'theme2.wav', 'seashanty2.wav', 'Proy_1_theme_1.wav', 'Proy_1_theme_2.wav', 'Proy_1_theme_3.wav'};
            app.AudioFileDropDown.ValueChangedFcn = createCallbackFcn(app, @AudioFileDropDownValueChanged, true);
            app.AudioFileDropDown.Position = [100 463 110 14];
            app.AudioFileDropDown.Value = 'Seleccionar';

            % Create DuracinEditFieldLabel
            app.DuracinEditFieldLabel = uilabel(app.LeftPanel);
            app.DuracinEditFieldLabel.HorizontalAlignment = 'right';
            app.DuracinEditFieldLabel.Position = [21 386 54 22];
            app.DuracinEditFieldLabel.Text = 'Duración';

            % Create DuracinEditField
            app.DuracinEditField = uieditfield(app.LeftPanel, 'text');
            app.DuracinEditField.HorizontalAlignment = 'center';
            app.DuracinEditField.Position = [102 386 86 22];

            % Create FrecuenciadeMuestreoLabel
            app.FrecuenciadeMuestreoLabel = uilabel(app.LeftPanel);
            app.FrecuenciadeMuestreoLabel.HorizontalAlignment = 'center';
            app.FrecuenciadeMuestreoLabel.VerticalAlignment = 'top';
            app.FrecuenciadeMuestreoLabel.WordWrap = 'on';
            app.FrecuenciadeMuestreoLabel.Position = [18 328 69 38];
            app.FrecuenciadeMuestreoLabel.Text = 'Frecuencia de Muestreo';

            % Create FrecuenciadeMuestreoEditField
            app.FrecuenciadeMuestreoEditField = uieditfield(app.LeftPanel, 'text');
            app.FrecuenciadeMuestreoEditField.HorizontalAlignment = 'center';
            app.FrecuenciadeMuestreoEditField.Position = [102 344 86 22];

            % Create sLabel
            app.sLabel = uilabel(app.LeftPanel);
            app.sLabel.Position = [195 386 13 22];
            app.sLabel.Text = 's';

            % Create HzLabel
            app.HzLabel = uilabel(app.LeftPanel);
            app.HzLabel.Position = [194 344 23 22];
            app.HzLabel.Text = 'Hz';

            % Create AnchodeBandaEditFieldLabel
            app.AnchodeBandaEditFieldLabel = uilabel(app.LeftPanel);
            app.AnchodeBandaEditFieldLabel.HorizontalAlignment = 'center';
            app.AnchodeBandaEditFieldLabel.VerticalAlignment = 'top';
            app.AnchodeBandaEditFieldLabel.WordWrap = 'on';
            app.AnchodeBandaEditFieldLabel.Position = [18 287 69 38];
            app.AnchodeBandaEditFieldLabel.Text = 'Ancho de Banda';

            % Create AnchodeBandaEditField
            app.AnchodeBandaEditField = uieditfield(app.LeftPanel, 'text');
            app.AnchodeBandaEditField.HorizontalAlignment = 'center';
            app.AnchodeBandaEditField.Position = [102 303 86 22];

            % Create NotasTextAreaLabel
            app.NotasTextAreaLabel = uilabel(app.LeftPanel);
            app.NotasTextAreaLabel.HorizontalAlignment = 'center';
            app.NotasTextAreaLabel.FontSize = 14;
            app.NotasTextAreaLabel.FontWeight = 'bold';
            app.NotasTextAreaLabel.Position = [88 224 44 22];
            app.NotasTextAreaLabel.Text = {'Notas'; ''};

            % Create NotasTextArea
            app.NotasTextArea = uitextarea(app.LeftPanel);
            app.NotasTextArea.Position = [8 6 206 211];

            % Create PlayButton
            app.PlayButton = uibutton(app.LeftPanel, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.BackgroundColor = [0.9412 0.9412 0.9412];
            app.PlayButton.Position = [100 426 100 22];
            app.PlayButton.Text = {'Play'; ''};

            % Create Button
            app.Button = uibutton(app.LeftPanel, 'push');
            app.Button.Position = [1 502 2 2];

            % Create Button2
            app.Button2 = uibutton(app.LeftPanel, 'push');
            app.Button2.Position = [1 502 2 2];
            app.Button2.Text = 'Button2';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 2;

            % Create DomTiempo
            app.DomTiempo = uiaxes(app.RightPanel);
            title(app.DomTiempo, 'Theme Dominio del tiempo')
            xlabel(app.DomTiempo, 'Tiempo [s]')
            ylabel(app.DomTiempo, 'Amplitud')
            zlabel(app.DomTiempo, 'Z')
            app.DomTiempo.Position = [21 246 393 236];

            % Create Picos
            app.Picos = uiaxes(app.RightPanel);
            title(app.Picos, {'Picos'; ''})
            xlabel(app.Picos, 'X')
            ylabel(app.Picos, 'Y')
            zlabel(app.Picos, 'Z')
            app.Picos.Position = [21 24 393 210];

            % Create Espect
            app.Espect = uiaxes(app.RightPanel);
            title(app.Espect, 'Espectrograma')
            app.Espect.XTick = [];
            app.Espect.YTick = [];
            app.Espect.Position = [449 245 396 236];

            % Create SFinal
            app.SFinal = uiaxes(app.RightPanel);
            title(app.SFinal, 'Señal Final')
            xlabel(app.SFinal, 'X')
            ylabel(app.SFinal, 'Y')
            zlabel(app.SFinal, 'Z')
            app.SFinal.Position = [449 24 404 210];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Aplicacion_Proyecto

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