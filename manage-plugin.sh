#!/usr/bin/env bash
set -euo pipefail

repo_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

names=(agent-architect developer teacher my-style)
descs=(
    "Thiet ke va tao moi cac AI sub-agent chuyen nghiep"
    "Review commit (Android, Qt C++/C), code Python, bao mat, hieu nang"
    "Agent giao vien GDCD / Giao duc kinh te va phap luat"
    "Nguyen tac va phong cach ca nhan ap dung xuyen suot moi du an"
)

echo
echo "=== Ban muon lam gi? ==="
echo "  [1] Install (cai dat plugin)"
echo "  [2] Uninstall (go cai dat plugin)"
echo
read -rp "Chon 1 hoac 2: " action

if [[ "$action" == "2" ]]; then
    mode="uninstall"
else
    mode="install"
fi

echo
if [[ "$mode" == "install" ]]; then
    echo "=== Danh sach plugin co the cai dat ==="
else
    echo "=== Danh sach plugin co the go cai dat ==="
fi
for i in "${!names[@]}"; do
    printf "  [%d] %s - %s\n" "$((i + 1))" "${names[$i]}" "${descs[$i]}"
done
echo "  [0] Tat ca"
echo

if [[ "$mode" == "install" ]]; then
    verb_vi="cai"
else
    verb_vi="go"
fi
read -rp "Go so thu tu (vd: 1 3) hoac ten plugin (vd: developer teacher), hoac 0 de $verb_vi tat ca: " answer

read -ra tokens <<< "$answer"

selected=()
select_all=false
if [[ ${#tokens[@]} -eq 0 ]]; then
    select_all=true
else
    for t in "${tokens[@]}"; do
        [[ "$t" == "0" ]] && select_all=true && break
    done
fi

if [[ "$select_all" == true ]]; then
    selected=("${names[@]}")
else
    for t in "${tokens[@]}"; do
        if [[ "$t" =~ ^[0-9]+$ ]]; then
            idx=$((t - 1))
            if [[ $idx -ge 0 && $idx -lt ${#names[@]} ]]; then
                selected+=("${names[$idx]}")
            else
                echo "Warning: so thu tu khong hop le: $t (bo qua)" >&2
            fi
        else
            found=false
            for n in "${names[@]}"; do
                if [[ "$n" == "$t" ]]; then
                    selected+=("$t")
                    found=true
                    break
                fi
            done
            if [[ "$found" == false ]]; then
                echo "Warning: khong tim thay plugin: $t (bo qua)" >&2
            fi
        fi
    done
fi

unique_selected=()
for s in "${selected[@]:-}"; do
    [[ -z "$s" ]] && continue
    skip=false
    for u in "${unique_selected[@]:-}"; do
        if [[ "$u" == "$s" ]]; then
            skip=true
            break
        fi
    done
    [[ "$skip" == false ]] && unique_selected+=("$s")
done

if [[ ${#unique_selected[@]} -eq 0 ]]; then
    echo "Khong co plugin nao duoc chon. Da huy."
    exit 0
fi

if [[ "$mode" == "uninstall" ]]; then
    read -rp "Xac nhan go cai dat: ${unique_selected[*]} ? (y/N) " confirm
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
        echo "Da huy."
        exit 0
    fi

    for plugin in "${unique_selected[@]}"; do
        echo "Uninstalling plugin: $plugin"
        claude plugin uninstall "$plugin@dev-quality-toolkit"
    done
else
    echo
    echo "Adding marketplace: dev-quality-toolkit ($repo_path)"
    claude plugin marketplace add "$repo_path"

    for plugin in "${unique_selected[@]}"; do
        echo "Installing plugin: $plugin"
        claude plugin install "$plugin@dev-quality-toolkit"
    done
fi

echo
echo "Done. Run 'claude plugin list' to verify."
