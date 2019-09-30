#!/bin/bash
TODO:
backup vault from phone to /home
move EnpassPortable to bin/enpass



####    ####
"_program=$inv_program_cur_ &&  _version_cur=$inv_version_cur_  && _install_path=$inv_install_path_curr_"
_program=enpass  &&  _version_cur=6.0.7  && _install_path=/opt/enpass
####

set_tuning_vars(){
    _layer0_check="true"
    _program="enpass"
    _user_agent='Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/67.0'
    _autopath_path="/etc/profile.d/opt_autopath.sh"

add_program(){
    _program="enpass"
    _install_path="/opt/$_program"

    _link_trigger=$(enpass_get_link)
    }

    
check_autopath(){
    grep '# opt_autopath' /etc/profile.d/opt_autopath.sh
    if \
        [ $? -eq 0 ]
      then\
        opt_autopath=true
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
            ' > $_autopath_path
            }

version_cur(){
    version_cur=$(\
        grep "$_program" '/opt/clr_opt_programs.inv' |\
        xargs . \
        )}

enpass_get_link(){
    link=$(\
    curl -vkLA \
    $_user_agent \
    $_base_url |\
    sed -n 's/.*href="\([^"]*\).*/\1/p' |\
    grep 'portable/linux' \
    )}

get_version(){
    version_new=$(\
    echo $link |\
    sed 's/\// /g' |\
    awk '{print $6}' \
    )}

layer0_check(){
    echo \
    'Caution!!! will delete current vault, \
    ensure you have backed up outside the /opt/enpass folder...' \
    while true
      do
        read -p "Update from: Enpass $version_cur to $version_new" yn
            case $yn in
                [Yy]* ) make install; break;;
                [Nn]* ) exit;;
                * ) echo "Please answer yes or no.";;
                esac
                done
                }

read_fanisfest(){
    grep -f 

write_manifest(){
    echo "$_program    $_install_path    $_version_new"   >>   clr_user_programs.inv
    
}

program_remove_cur(){
    rm -rf $_install_path
    rm -rf ~/Downloads/Enpass*
    rm -rf ~/Downloads/enpass*
    }


main(){
    for i in /opt/clr_opt_programs.inv
      do
    
    }

clr_opt_program_create(){
    inv_program_cur_=$_program_cur
    inv_version_cur_=$version_new
    inv_install_path_=$_install_path
    tee "_program=$inv_program_cur_ &&  _version_cur=$inv_version_cur_  && _install_path=$inv_install_path_" \
    >> "/opt/clr_opt_programs.inv"
    }








