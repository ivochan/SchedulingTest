%% Analisi esatta del tempo di risposta di un processo di Joseph e Pandya
%
function [] = response_time_exact_analisys(n,c,t,d)

    %% Calcolo della priorita' dei processi

    [alpha,min_p_index,max_p_index] = process_priority_calculation(t);
    
    % vettore delle priorita'
    fprintf('Il vettore delle priorit� � alpha � : [');
    fprintf('%g, ', alpha(1:end-1));
    fprintf('%g]\n', alpha(end));
    
    % processo con priorita' minore
    fprintf('\nIl processo a priorit� minore � P%d.',min_p_index)
    
    % processo con priorita' maggiore
    fprintf('\nIl processo a priorit� maggiore � P%d.\n\n',max_p_index)
    
    % high priority set di ogni processo
    hp_M = zeros(n);
    
    % si iterano le righe della matrice del set hp
    for i = 1:n
        % si iterano le colonne
        for j = 1:n
            % si popola l'high priority set del processo i-esimo
            % iterando il vettore delle priorita'
            if alpha(i) < alpha(j)
                % il processo i-esimo e' meno prioritatio del processo
                % j-esimo
                hp_M(i,j) = 1;
            end
        % for colonne        
        end
    % for righe
    end
    
    
    %% inizializzazioni
    % sommatoria
    sum = 0;
 
    %% Calcolo delle equazioni di ricorrenza di tutti i processi
    for i = 1:n
        % output
        fprintf('Eq. Ricorrenza del processo P%d...\n',i)
        
        % valore precedente del tempo di risposta
        pre_Wi = 0;
        
        % reset del flag per il ciclo di calcolo
        done = 0;
        
        % ciclo di calcolo della equazione di ricorrenza i-esima
        while (~done)
            % ciclo for
            for j = 1:n
                % si esclude il processo corrente dal calcolo
                if j ~= i
                    % si considera il processo che appartiene all' hp set
                    if hp_M(i,j)
                        % fattore pre_Ri/Tj
                        factor = pre_Wi/t(j);
                        % funzione di ceiling del fattore precedente
                        ceiling_factor = ceil(factor);
                        % prodotto
                        mul = ceiling_factor*c(j);
                        % sommatoria
                        sum = sum + mul; 
                    % fi    
                    end               
                else
                    % per il processo i-esimo si conta solo il costo di
                    % esecuzione
                    Wi = c(j);
                end
            % end for                  
            end 
            %si aggiunge il costo
            Wi = Wi + sum; 
            % si resetta la sommatoria
            sum = 0;
            % output
            % fprintf('W%d = %d \n',i,Wi);
            
            % controllo di Ri
            if Wi == pre_Wi
                % l'algoritmo si ferma
                done = 1;
                % si assegna il valore del tempo di risposta
                Ri = Wi;
                % output
                fprintf('R%d = %d.\n',i,Ri);
                % verifca della deadline
                [flag] = deadline_check(Ri,d(i));
                % se la deadline non viene rispettata
                if ~flag
                    % si interrompe l'analisi
                    return;
                end
            % se valori diversi   
            else
            	% sia ggiorna il valore del tempo di risposta precedente
                pre_Wi = Wi;
            end
        % end while 
        end
    % end for           
    end

    % se la procedura non e' stata interrotta allora il task set e'
    % schedulabile
    fprintf('\nIl task set � schedulabile con Rate Monotonic.\n');
% end function
end
   