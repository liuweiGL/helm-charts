#!/bin/bash

set -e

# 定义 repository 目录
repo_dir="$PWD/repo"

# 定义 charts 目录
chart_dir="$PWD/charts"

function yq(){
    "$PWD/scripts/yq" $@
}

function get_chart_pkg_name(){
    chart_name=$(yq ".name" $1)
    chart_version="$(yq ".version" $1)"
    chart_pkg_name=$(printf "%s-%s" $chart_name $chart_version)
    echo "$chart_pkg_name.tgz"
}


function update_charts(){
    for item in "$chart_dir"/*; do
        # 检查是否有效的 Chart 目录
        if [[ -d "$item" && -f "$item/Chart.yaml" ]]; then
            chart_pkg_name=$(get_chart_pkg_name "$item/Chart.yaml")
            if [[ -f "$repo_dir/$chart_pkg_name" ]]; then
                echo "Package $chart_pkg_name is existed, skip"
            else
                helm package $item -d $repo_dir
            fi
        fi
    done
}

function update_index(){
    helm repo index $repo_dir --merge $repo_dir/index.yaml
}



function main(){
    update_charts
    update_index
}

main

# if [ $# -lt 1 ]; then
#     echo "Usage: $0 <method>"
#     exit 1
# fi

# method="$1"

# case "$method" in
#     "update_charts")
#         update_charts
#         ;;
#     "update_index")
#         update_index
#         ;;
#     *)
#         echo "Unknown method: $method"
#         exit 1
#         ;;
# esac