codeunit 70311 "TURFInventory Mgt"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInsertPhysInventoryEntry', '', false, false)]
    local procedure ItemJnlPostLineOnAfterInsertPhysInventoryEntry(ItemJournalLine: Record "Item Journal Line")
    var
        Item: Record Item;
    begin
        Item.get(ItemJournalLine."Item No.");
        if Item."Last Counting Period Update" < ItemJournalLine."Posting Date" then begin
            Item.validate("Last Counting Period Update", ItemJournalLine."Posting Date");
            Item.Modify(false);
        end;
    end;
}