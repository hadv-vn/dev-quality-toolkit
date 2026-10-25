"""Helper dung chung de tao slide bai giang tu teacher/templates/slide_template.pptx.

Cach dung dien hinh (trong script sinh bai giang cua skill slide-design):

    from pptx import Presentation
    import pptx_helpers as h

    prs = Presentation(h.TEMPLATE_PATH)

    cover = h.duplicate_slide(prs, h.LAYOUT["cover"])
    h.set_text(cover, "eyebrow", "GDCD 9 · BAI 5")
    h.set_text(cover, "title", "Ten bai hoc")
    h.set_text(cover, "subtitle", "Mo ta ngan")
    h.set_icon(cover, "icon_book", h.icon_path("lightbulb"))

    ... (nhan ban them cac slide khac theo nhu cau) ...

    h.delete_template_slides(prs)   # xoa 7 slide mau goc, chi giu slide da nhan ban
    prs.save("BaiGiang_....pptx")

LUU Y: slide_template.pptx la file CHI DOC (dung lam nguon nhan ban). Khong
bao gio prs.save() de de len chinh file nay.
"""
import copy
import json
import os

from pptx.oxml.ns import qn

HERE = os.path.dirname(os.path.abspath(__file__))
TEMPLATE_PATH = os.path.join(HERE, "slide_template.pptx")
THEME = json.load(open(os.path.join(HERE, "theme.json"), encoding="utf-8"))
ICONS_DIR = os.path.join(HERE, THEME["icons_dir"])

# Thu tu slide trong slide_template.pptx (xem build_template.py)
LAYOUT = {
    "cover": 0,
    "divider": 1,
    "cards_2x2": 2,
    "icon_list": 3,
    "compare_quote": 4,
    "dark_checklist": 5,
    "closing": 6,
}
TEMPLATE_SLIDE_COUNT = len(LAYOUT)


def icon_path(icon_name):
    path = os.path.join(ICONS_DIR, f"{icon_name}.png")
    if not os.path.exists(path):
        raise FileNotFoundError(
            f"Khong co icon '{icon_name}'. Danh sach icon hop le: {THEME['icons']}"
        )
    return path


def find_shape(slide, shape_name):
    for shp in slide.shapes:
        if shp.name == shape_name:
            return shp
    raise KeyError(f"Khong tim thay shape '{shape_name}' trong slide nay")


def set_text(slide, shape_name, text):
    """Thay noi dung placeholder [[...]] bang text that, giu nguyen dinh dang font."""
    shp = find_shape(slide, shape_name)
    run = shp.text_frame.paragraphs[0].runs[0]
    run.text = text
    return shp


def set_icon(slide, shape_name, new_icon_name):
    """Thay anh icon cua mot shape da dat ten (vd 'card1_icon', 'row2_icon')."""
    shp = find_shape(slide, shape_name)
    left, top, width, height, name = shp.left, shp.top, shp.width, shp.height, shp.name
    sp = shp._element
    sp.getparent().remove(sp)
    new_pic = slide.shapes.add_picture(icon_path(new_icon_name), left, top, width, height)
    new_pic.name = name
    return new_pic


def duplicate_slide(prs, template_index):
    """Nhan ban 1 slide mau (theo index trong LAYOUT) vao cuoi presentation dang dung.

    prs PHAI la Presentation(TEMPLATE_PATH) dang mo (chua 7 slide mau o dau).
    """
    src = prs.slides[template_index]
    dest = prs.slides.add_slide(src.slide_layout)

    for shp in list(dest.shapes):
        shp._element.getparent().remove(shp._element)

    rid_map = {}
    for rId, rel in src.part.rels.items():
        if rel.is_external:
            continue
        new_rid = dest.part.relate_to(rel.target_part, rel.reltype)
        rid_map[rId] = new_rid

    for shp in src.shapes:
        new_el = copy.deepcopy(shp._element)
        dest.shapes._spTree.append(new_el)
        for blip in new_el.iter(qn("a:blip")):
            old_rid = blip.get(qn("r:embed"))
            if old_rid and old_rid in rid_map:
                blip.set(qn("r:embed"), rid_map[old_rid])

    return dest


def delete_slide(prs, index):
    xml_slides = prs.slides._sldIdLst
    slides = list(xml_slides)
    xml_slides.remove(slides[index])


def delete_template_slides(prs):
    """Xoa het N slide mau goc o dau file (N = TEMPLATE_SLIDE_COUNT).

    Goi ham nay SAU CUNG, sau khi da duplicate_slide() toan bo slide can dung -
    vi duplicate_slide() doc tu cac slide mau theo index co dinh trong LAYOUT.
    """
    for i in range(TEMPLATE_SLIDE_COUNT - 1, -1, -1):
        delete_slide(prs, i)
