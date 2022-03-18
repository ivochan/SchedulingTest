%% Calcolo dell'equazione di ricorrenza di un processo
function [Ri] = response_time_calculation(i,n,c,t,d)
    %% inizializzazioni
	% tempo di risposta precedente
    pre_Ri = 0;
    % tempo di risposta corrente
    Ri = 0;
    % sommatoria
    summation = 0;
    % flag
    done = 1;
   
    %% calcolo dell'equazione di ricorrenza del processo Pi
    fprintf('\nEquazione di ricorrenza del processo P%d...\n',i);
    
    while (done)
        % ciclo for
        for j = 1:n
            % si esclude il processo corrente dal calcolo
            if j ~= i
                % fattore pre_Ri/Tj
                %factor = pre_Ri/t(1:n)
                factor = pre_Ri/t(j)
                % funzione di ceiling del fattore precedente
                ceiling_factor = ceil(factor);
                % sommatoria
                summation =summation + ceiling_factor*c(j)
              
            end     
            % si aggiunge alla sommatoria il costo di Pi       
            % calcolo del tempo di risposta corrente aggiungendo alla
            % sommatoria il costo di Pi               
            Ri = c(i) + summation(1:end);
          
            %% verifica del valore del tempo di risposta
            % se uguale al precedente l'equazione di ricorrenza si interrompe
            if Ri == pre_Ri
                % si interrompe il ciclo
                done = 1;
                % l'algoritmo si interrompe
                fprintf('\nR%d = %d ed � pari a quello assunto nell''iterazione precedente.\n',i,Ri);         
                % si verifica se minore della deadline
                flag = deadline_check(Ri,d(i));
                % si verifica se la relazione Ri <= Di e' soddisfatta
                if ~flag
                    % se non e' soddisfatta si interrompe la procedura
                    return;
                % fine verifica deadline
                end
            % il valore Ri e' diverso dal precedente    
            else
                % si aggiorna
                pre_Ri = Ri;
                % output
                fprintf('Il tempo di risposta del processo P%d all''iterazione %d � %d.\n',i,j,Ri) 
            % fine if-else termine di interruzione del calcolo dell'eq
            end
        % end for  
        end
    % end while    
    end
% end function
end
    
        

               