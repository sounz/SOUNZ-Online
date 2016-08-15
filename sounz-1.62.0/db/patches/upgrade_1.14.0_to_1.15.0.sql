begin;

-- WR#50286 - clear out Manifestation duration
update manifestations set duration = null where duration is not null;

-- WR#50286 - EXPRESSIONS - require a duration field
alter table expressions add column duration INTERVAL;

commit;