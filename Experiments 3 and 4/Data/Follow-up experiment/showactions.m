% Illustrate the sequence of events for each crystals subject

close all;
clear all;

figuresize = [0 0 10 8];

datapath = './';
w = what(datapath);
files = w.mat;

ID = 1;
HUE = 2;
SAT = 3;
LEN = 4;
POS = 5;

figureRows = 6;
figureCols = 8;

for f=1:length(files)
    load(strcat(datapath,files{f}));

	for cond=1:3
		actions = userps.newcrystalactions{1}{cond};
		%crystals = cell(6);
		for ci=3:8
			c.active = 0;
			c.hue = 0;
			c.sat = 0;
			c.len = 0;
			c.pos = [0 0 0 0];
			crystals{ci} = c;
		end
		
		currFig = figure();
		set(gcf, 'PaperUnits', 'inches');
		set(gcf, 'PaperPosition', figuresize);
		currFigNum = 1;
		currPanel = 1;
		
		for ai=0:(actions.size()-1)
		
			% Get the action
			a = actions.get(ai);
			
			% Check if this is a crystal we care about
			if (a(ID) < 3)
				continue;
			end
			
			if (currPanel > figureRows*figureCols)
				% Save the current figure
%				figName = sprintf('figures/%d_%d_%d',f,cond,currFigNum);
%				print('-depsc',figName);
				
				currFig = figure();
				set(gcf, 'PaperUnits', 'inches');
				set(gcf, 'PaperPosition', figuresize);
				currFigNum = currFigNum+1;
				currPanel = 1;
			end
			
			p = subplot(figureRows, figureCols, currPanel);
			axis([0.66 1 0 0.7]);
			hold on;
			set(p, 'xtick', [], 'ytick', [], 'Color', 'white');
			
			
			% Update the crystals
			crystals{a(ID)}.active = 1;
			crystals{a(ID)}.hue = a(HUE);
			crystals{a(ID)}.sat = a(SAT);
			crystals{a(ID)}.len = a(LEN);
			crystals{a(ID)}.pos = a(POS);
			
			
			% Draw all the crystals
			for ci=3:8
				if (crystals{ci}.active == 1)
					color = hsv2rgb([crystals{ci}.hue crystals{ci}.sat 1]);
					Xpos = [crystals{ci}.pos(1) crystals{ci}.pos(1) ...
							crystals{ci}.pos(1)+crystals{ci}.len*0.25 ...
							crystals{ci}.pos(1)+crystals{ci}.len*0.25];
					Ypos = [crystals{ci}.pos(2) crystals{ci}.pos(2)+.05 ...
							crystals{ci}.pos(2)+.05 ...
							crystals{ci}.pos(2)];
					fill(Xpos,Ypos,color);
					hold on;
				end
			end
			
			t = sprintf('%d.%d -- %d.%d',f,cond,currFigNum,currPanel);
			title(t);
			
			hold off;
			
			currPanel = currPanel+1;
		end
		
		% Write out the last figure
%		figName = sprintf('figures/%d_%d_%d',f,cond,currFigNum);
%		print('-depsc',figName);
	end
end
