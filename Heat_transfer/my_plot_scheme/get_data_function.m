function data_n=get_data_function(name,num,dim)

if(isempty(num)==1)
    myfig = open(name);
    
else
   myfig=figure(num);
end

my_legend=findobj(myfig, 'Type', 'Legend');
legend(gca,'off');
axObjs = myfig.Children;
dataObjs = axObjs.Children;
[lines_n,b]=size(dataObjs);


data_n=cell(1,lines_n);
if(dim==3)
    for num=1:lines_n
        data_n{num}.x = dataObjs(num).XData;
        data_n{num}.y = dataObjs(num).YData;
        data_n{num}.z = dataObjs(num).ZData;
    end
end

if(dim==2)
    for num=1:lines_n
        data_n{num}.x = dataObjs(num).XData;
        data_n{num}.y = dataObjs(num).YData;
       
    end
end

end