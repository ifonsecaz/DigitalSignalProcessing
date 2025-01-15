classdef ProyectoFinalApp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        TituloLbl                      matlab.ui.control.Label
        EscucharButton                 matlab.ui.control.Button
        LabelListo                     matlab.ui.control.Label
        NotascontenidasenlamelodasintetizadaLabel  matlab.ui.control.Label
        BuscarButton                   matlab.ui.control.Button
        UITable                        matlab.ui.control.Table
        EjecutarButton                 matlab.ui.control.Button
        EjecutarelanlisisylageneracindelarchivodesntesisLabel  matlab.ui.control.Label
        SeleccionarelconteodebpmLabel  matlab.ui.control.Label
        BPMSpinner                     matlab.ui.control.Spinner
        BPMSpinnerLabel                matlab.ui.control.Label
        Image                          matlab.ui.control.Image
        InformacinsobrelamelodaLabel   matlab.ui.control.Label
        SeleccionarlaimagendelapartituraLabel  matlab.ui.control.Label
        PartiturasDDL                  matlab.ui.control.DropDown
        PartiturasDropDownLabel        matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
           
        end

        % Value changed function: PartiturasDDL
        function PartiturasDDLValueChanged(app, event)
            value = app.PartiturasDDL.Value;
            app.Image.ImageSource = value;
            app.TituloLbl.Text = value;
        end

        % Button pushed function: EjecutarButton
        function EjecutarButtonPushed(app, event)
            numDivisiones=DivisionPartitura(app.PartiturasDDL.Value);
            [frec, sim]=interpNotas();
            [t, tfinal, fs]=VectorTiempos(sim,app.BPMSpinner.Value,numDivisiones);
            SintesisDeNotas(frec,t,fs,tfinal);
            
            %GUI para mostrar las notas identificadas. Obtenido de:
            %https://www.mathworks.com/matlabcentral/fileexchange/17290-image-gallery
            run('ImageGallery/imageGallery.m')
            app.LabelListo.Visible = 'on';
            app.EscucharButton.Visible = 'on';
        end

        % Callback function
        function UploadButtonPushed(app, event)
            archivo = app.SubirarchivoEditField_2.Value;
            if ~any(ismember(app.PartiturasDDL.Items, archivo))
                app.PartiturasDDL.Items = [app.PartiturasDDL.Items archivo];
            end
        end

        % Button pushed function: BuscarButton
        function BuscarButtonPushed(app, event)
            
            path=uigetdir;
            app.UIFigure.Visible = 'off';
            app.UIFigure.Visible = 'on';

            a=dir(path);
            b={a(:).name}';
            b(ismember(b,{'.','..'})) = [];

            
            app.UITable.Data=b;                  
        end

        % Cell selection callback: UITable
        function UITableCellSelection(app, event)
            indices = event.Indices;
            data_cell = get(app.UITable, 'Data');
            archivo = data_cell{indices,1};
            if ~any(ismember(app.PartiturasDDL.Items, archivo))
                app.PartiturasDDL.Items = [app.PartiturasDDL.Items archivo];
            end
        end

        % Button pushed function: EscucharButton
        function EscucharButtonPushed(app, event)
            [y,fs] = audioread('ProyectoFinal/salida.wav');
            sound(y,fs)
            
            fullname = 'C:\Users\Rodp\Documents\Semestre 8\Procesamiento Digital\LAB\Proyecto2\ProyectoFinal (1)\ProyectoFinal\salida.wav';
            try
                [y, Fs] = audioread(fullname);
                PO=audioplayer(y,Fs);
                % Play audio
                playblocking(PO)
            catch ME
                uiwait(msgbox('Could not open that file with audioread'));
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [0 0 1150 695];
            app.UIFigure.Name = 'MATLAB App';

            % Create PartiturasDropDownLabel
            app.PartiturasDropDownLabel = uilabel(app.UIFigure);
            app.PartiturasDropDownLabel.HorizontalAlignment = 'right';
            app.PartiturasDropDownLabel.Position = [52 613 57 22];
            app.PartiturasDropDownLabel.Text = 'Partituras';

            % Create PartiturasDDL
            app.PartiturasDDL = uidropdown(app.UIFigure);
            app.PartiturasDDL.Items = {'-', ''};
            app.PartiturasDDL.ValueChangedFcn = createCallbackFcn(app, @PartiturasDDLValueChanged, true);
            app.PartiturasDDL.Position = [124 612 100 22];
            app.PartiturasDDL.Value = '-';

            % Create SeleccionarlaimagendelapartituraLabel
            app.SeleccionarlaimagendelapartituraLabel = uilabel(app.UIFigure);
            app.SeleccionarlaimagendelapartituraLabel.FontWeight = 'bold';
            app.SeleccionarlaimagendelapartituraLabel.Position = [40 645 236 22];
            app.SeleccionarlaimagendelapartituraLabel.Text = '1.  Seleccionar la imagen de la partitura.';

            % Create InformacinsobrelamelodaLabel
            app.InformacinsobrelamelodaLabel = uilabel(app.UIFigure);
            app.InformacinsobrelamelodaLabel.FontWeight = 'bold';
            app.InformacinsobrelamelodaLabel.Position = [788 605 193 22];
            app.InformacinsobrelamelodaLabel.Text = '3.  Información sobre la melodía.';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [660 12 451 533];

            % Create BPMSpinnerLabel
            app.BPMSpinnerLabel = uilabel(app.UIFigure);
            app.BPMSpinnerLabel.HorizontalAlignment = 'right';
            app.BPMSpinnerLabel.Position = [52 491 32 22];
            app.BPMSpinnerLabel.Text = 'BPM';

            % Create BPMSpinner
            app.BPMSpinner = uispinner(app.UIFigure);
            app.BPMSpinner.Position = [111 491 100 22];

            % Create SeleccionarelconteodebpmLabel
            app.SeleccionarelconteodebpmLabel = uilabel(app.UIFigure);
            app.SeleccionarelconteodebpmLabel.FontWeight = 'bold';
            app.SeleccionarelconteodebpmLabel.Position = [40 523 196 22];
            app.SeleccionarelconteodebpmLabel.Text = '2.  Seleccionar el conteo de bpm.';

            % Create EjecutarelanlisisylageneracindelarchivodesntesisLabel
            app.EjecutarelanlisisylageneracindelarchivodesntesisLabel = uilabel(app.UIFigure);
            app.EjecutarelanlisisylageneracindelarchivodesntesisLabel.FontWeight = 'bold';
            app.EjecutarelanlisisylageneracindelarchivodesntesisLabel.Position = [120 383 362 22];
            app.EjecutarelanlisisylageneracindelarchivodesntesisLabel.Text = '4.  Ejecutar el análisis y la generación del archivo de síntesis.';

            % Create EjecutarButton
            app.EjecutarButton = uibutton(app.UIFigure, 'push');
            app.EjecutarButton.ButtonPushedFcn = createCallbackFcn(app, @EjecutarButtonPushed, true);
            app.EjecutarButton.Position = [251 340 100 22];
            app.EjecutarButton.Text = 'Ejecutar';

            % Create UITable
            app.UITable = uitable(app.UIFigure);
            app.UITable.ColumnName = {'Archivos'};
            app.UITable.RowName = {};
            app.UITable.CellSelectionCallback = createCallbackFcn(app, @UITableCellSelection, true);
            app.UITable.Position = [295 463 281 204];

            % Create BuscarButton
            app.BuscarButton = uibutton(app.UIFigure, 'push');
            app.BuscarButton.ButtonPushedFcn = createCallbackFcn(app, @BuscarButtonPushed, true);
            app.BuscarButton.Position = [480 641 94 23];
            app.BuscarButton.Text = 'Buscar';

            % Create NotascontenidasenlamelodasintetizadaLabel
            app.NotascontenidasenlamelodasintetizadaLabel = uilabel(app.UIFigure);
            app.NotascontenidasenlamelodasintetizadaLabel.FontWeight = 'bold';
            app.NotascontenidasenlamelodasintetizadaLabel.Position = [162 267 277 22];
            app.NotascontenidasenlamelodasintetizadaLabel.Text = '5.  Notas contenidas en la melodía sintetizada. ';

            % Create LabelListo
            app.LabelListo = uilabel(app.UIFigure);
            app.LabelListo.HorizontalAlignment = 'center';
            app.LabelListo.FontSize = 32;
            app.LabelListo.FontWeight = 'bold';
            app.LabelListo.FontColor = [0.4667 0.6745 0.1882];
            app.LabelListo.Visible = 'off';
            app.LabelListo.Position = [251 211 103 39];
            app.LabelListo.Text = '¡Listo!';

            % Create EscucharButton
            app.EscucharButton = uibutton(app.UIFigure, 'push');
            app.EscucharButton.ButtonPushedFcn = createCallbackFcn(app, @EscucharButtonPushed, true);
            app.EscucharButton.FontSize = 16;
            app.EscucharButton.Visible = 'off';
            app.EscucharButton.Position = [224 142 157 43];
            app.EscucharButton.Text = 'Escuchar';

            % Create TituloLbl
            app.TituloLbl = uilabel(app.UIFigure);
            app.TituloLbl.HorizontalAlignment = 'center';
            app.TituloLbl.FontSize = 36;
            app.TituloLbl.FontWeight = 'bold';
            app.TituloLbl.Position = [659 516 452 45];
            app.TituloLbl.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ProyectoFinalApp_exported

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