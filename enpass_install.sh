#!/bin/bash
####    ####
# install latest portable enpass from official site in /opt/enpass
# backup vault outside /opt/enpass before rerunning to update
# set layer0 check to false to automate / disable dialog/warnings

tuning_vars_set(){
    echo 'setting tuning vars'
    _layer0_check="true"
    _program="enpass"
    _install_path="/opt/$_program"
    _user_agent='Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/67.0'
    _run_as_sudo="true"
    _base_url='https://www.enpass.io/beta'
    _auto_opt_pat="true"

root_check(){
    if \
        [[ "${_run_as_sudo}" == 'true' ]] \
        && \
        [[  "${EUID}" -gt "0" ]]  
      then
        break
      else 
        echo "must be run as sudo" && exit 1
            fi;}

layer0_check(){
    echo "layer0 check"
    echo \
    "Caution!!! will delete current vault, \
    if updating, did you back back up vault outside the /opt/enpass folder?" \
    while true
      do
        read -p "Update from: Enpass $version_cur to $version_new" yn
            case $yn in
                [Yy]* ) ; break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
                esac
                done;}

check_autopath(){
    autopath_path=/etc/profile.d/opt_autopath.sh
    grep '# opt_autopath' $_autopath_path
    if \
        [ $? -eq 0 ]
      then\
        opt_autopath="true"
        fi;}

create_opt_autopath(){
    tee '#!/bin/bash
for \
    d in /opt/*/bin
    do
        test -d "$d" || continue
        case \
            :$PATH: in
            *:"$d":*);;
            *) PATH=${PATH:+$PATH:}$d;;
            esac
            done
            ' > $autopath_path
            }

enpass_link_get(){
    link=$(\
    curl -vkLA \
        $_user_agent \
        $_base_url |\
        sed -n 's/.*href="\([^"]*\).*/\1/p' |\
        grep 'portable/linux' \
        )}

enpass_ver_get(){
    version_new=$(\
    echo $link |\
    sed 's/\// /g' |\
    awk '{print $6}' \
    )}

program_get(){
    program_archive=$(\
        echo "~/$_program$version_new.tar.gz" \
        )
    curl -vkLA $_user_agent $link -c "cookiejar.txt" \
        > $program_archive
        }

enpass_program_install(){
    tar xzf $program_archive
    rm $program_archive
    cd $(\
        ls |\
        grep -i enpassportable |\
        )
    mv $(ls) /opt/enpass
    }

main(){
    if \
        [[ _layer0_check == "true" ]] \
          && \
        [[ -f /opt/enpass/]]

      then
        layer0_check
        fi
    check_autopath
    if \
        [[ opt_autopath -eq "true" ]]
      then
        break
      else
        echo "You must configure your own PATH by adding /opt/enpass/bin"
        fi
    
}

main
